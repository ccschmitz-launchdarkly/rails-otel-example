tracer = OpenTelemetry.tracer_provider.tracer('rails.activerecord', '1.0')

ActiveSupport::Notifications.subscribe('sql.active_record') do |_name, started, finished, _unique_id, payload|
  # Skip SCHEMA queries and CACHE lookups to reduce noise
  next if payload[:name] == 'SCHEMA' || payload[:cached]

  # Determine the operation type from the SQL
  sql = payload[:sql]&.strip || ''
  operation = case sql
              when /\ASELECT/i then 'SELECT'
              when /\AINSERT/i then 'INSERT'
              when /\AUPDATE/i then 'UPDATE'
              when /\ADELETE/i then 'DELETE'
              when /\ABEGIN/i then 'BEGIN'
              when /\ACOMMIT/i then 'COMMIT'
              when /\AROLLBACK/i then 'ROLLBACK'
              else 'OTHER'
              end
  # Get database name - Rails 6.0 compatible approach
  db_name = if payload[:connection]&.pool&.respond_to?(:spec)
              payload[:connection].pool.spec.config[:database]
            else
              'unknown'
            end

  table_name = get_table_name(sql, payload[:name])

  # Create a span for this database query
  span_name = "#{operation} #{table_name}"
  duration_ns = ((finished - started).to_f * 1_000_000_000).round(2)

  # Convert start time to nanoseconds (OpenTelemetry's time format)
  start_timestamp_ns = started.to_f
  end_timestamp_ns = finished.to_f

  # Create the span with the actual start timestamp from when the query ran
  span = tracer.start_span(
    span_name,
    kind: :client,
    start_timestamp: start_timestamp_ns
  )

  begin
    # Add semantic conventions for database spans
    # See: https://opentelemetry.io/docs/specs/semconv/database/database-spans/
    span.set_attribute('db.system', payload[:connection]&.adapter_name || 'unknown')
    span.set_attribute('db.operation', operation)
    span.set_attribute('db.statement', sql)
    span.set_attribute('db.name', db_name)
    span.set_attribute('db.table', table_name)

    # Add Rails-specific attributes
    span.set_attribute('rails.active_record.name', payload[:name]) if payload[:name]
    span.set_attribute('rails.active_record.connection_id', payload[:connection_id]) if payload[:connection_id]
    span.set_attribute('rails.active_record.cached', payload[:cached]) if payload.key?(:cached)

    # Add duration as custom attribute (in milliseconds for readability)
    span.set_attribute('db.duration_ns', duration_ns)

    # Add bind parameters count (but not values for security)
    span.set_attribute('db.bind_count', payload[:binds].length) if payload[:binds]&.any?

    # If there was an exception, record it
    if payload[:exception_object]
      span.record_exception(payload[:exception_object])
      span.status = OpenTelemetry::Trace::Status.error("Database query failed: #{payload[:exception_object].message}")
    else
      span.status = OpenTelemetry::Trace::Status.ok
    end
  rescue StandardError => e
    # Handle any errors in span creation itself
    Rails.logger.error("Error creating OpenTelemetry span for SQL query: #{e.message}")
    span.record_exception(e) if span
    span.status = OpenTelemetry::Trace::Status.error(e.message) if span
  ensure
    # Finish the span with the actual end timestamp from when the query completed
    span&.finish(end_timestamp: end_timestamp_ns)
  end
end

# example sql: SELECT * FROM jobs, or EXECUTE my_procedure
# name: Job Load
def get_table_name(sql, name = '')
  unless name.blank?
    table_name = name.split(' ')[0]
    return table_name.downcase.pluralize if table_name
  end

  return table_name if table_name

  if sql.include?('FROM')
    table_name = sql.split('FROM')[1].split(' ')[0].downcase.pluralize
    return table_name if table_name
  end

  if sql.include?('EXECUTE')
    table_name = sql.split('EXECUTE')[1].split(' ')[0].downcase.pluralize
    return table_name if table_name
  end

  if sql.include?('INSERT INTO')
    table_name = sql.split('INSERT INTO')[1].split(' ')[0].downcase.pluralize
    return table_name if table_name
  end

  if sql.include?('UPDATE')
    table_name = sql.split('UPDATE')[1].split(' ')[0].downcase.pluralize
    return table_name if table_name
  end

  if sql.include?('DELETE FROM')
    table_name = sql.split('DELETE FROM')[1].split(' ')[0].downcase.pluralize
    return table_name if table_name
  end

  nil
end
