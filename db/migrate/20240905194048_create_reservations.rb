class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations, id: :uuid do |t|
      t.uuid :customer_id, null: false
      t.references :table, null: true, foreign_key: true, type: :uuid
      t.references :restaurant, null: false, foreign_key: true, type: :uuid
      t.integer :start_at
      t.integer :end_at
      t.integer :number_of_guests
      t.string :state
      t.datetime :date_of_reservation

      t.timestamps
    end

    add_index :reservations, :customer_id
  end
end
