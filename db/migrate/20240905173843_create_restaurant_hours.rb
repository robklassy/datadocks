class CreateRestaurantHours < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurant_hours, id: :uuid do |t|
      t.references :restaurant, null: false, foreign_key: true, type: :uuid
      t.string :day_of_week
      t.integer :open_at
      t.integer :close_at
      t.integer :max_time

      t.timestamps
    end
  end
end
