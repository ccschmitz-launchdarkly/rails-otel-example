Rails.application.routes.draw do
  scope :otel do
    get '/', to: 'otel_demo#index', as: :otel_demo
    post '/log', to: 'otel_demo#log', as: :otel_log
    post '/trace', to: 'otel_demo#trace', as: :otel_trace
    post '/http', to: 'otel_demo#http', as: :otel_http
    post '/handled_error', to: 'otel_demo#handled_error', as: :otel_handled_error
    post '/unhandled_error', to: 'otel_demo#unhandled_error', as: :otel_unhandled_error
    post '/background_job', to: 'otel_demo#background_job', as: :otel_background_job
  end

  root to: 'otel_demo#index'
end
