class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :company
      t.text :description
      t.decimal :salary
      t.string :location
      t.string :status

      t.timestamps
    end
  end
end
