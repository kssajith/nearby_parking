class CreateCarparks < ActiveRecord::Migration[6.0]
  def change
    create_table :carparks do |t|
      t.string :car_park_no
      t.string :address
      t.float :latitude
      t.float :longitude
      t.integer :car_park_type
      t.integer :type_of_parking_system
      t.string :short_term_parking
      t.string :free_parking
      t.integer :night_parking
      t.integer :car_park_decks
      t.float :gantry_height
      t.integer :car_park_basement

      t.timestamps
    end

    add_index :carparks, :car_park_no
  end
end
