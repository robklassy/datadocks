class CreateRestaurants < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurants, id: :uuid do |t|
      t.string :name
      t.string :web_url

      t.timestamps
    end
  end
end
