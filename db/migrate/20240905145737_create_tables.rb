class CreateTables < ActiveRecord::Migration[7.1]
  def change
    create_table :tables, id: :uuid do |t|
      t.string :identifier
      t.integer :number_of_seats
      t.boolean :active
      t.references :restaurant, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
