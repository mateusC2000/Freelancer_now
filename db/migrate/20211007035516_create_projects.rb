class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.string :requirements
      t.decimal :maximum_value_per_hour
      t.date :end_date
      t.integer :working_model

      t.timestamps
    end
  end
end
