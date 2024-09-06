class CreateServerTables < ActiveRecord::Migration[7.1]
  def change
    create_table :server_tables, id: :uuid do |t|
      t.uuid :server_id, null: false
      t.references :table, null: false, foreign_key: true, type: :uuid
      t.datetime :assigned_start_at
      t.datetime :assigned_end_at

      t.timestamps
    end

    add_index :server_tables, :server_id
  end
end
