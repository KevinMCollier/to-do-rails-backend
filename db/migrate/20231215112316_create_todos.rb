class CreateTodos < ActiveRecord::Migration[7.0]
  def change
    create_table :todos do |t|
      t.string :title
      t.datetime :date
      t.string :repeat
      t.string :day_of_week
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
