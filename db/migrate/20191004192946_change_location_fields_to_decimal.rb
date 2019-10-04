class ChangeLocationFieldsToDecimal < ActiveRecord::Migration[6.0]
  def change
    change_column :carparks, :latitude, :decimal, { precision: 10, scale: 6 }
    change_column :carparks, :longitude, :decimal, { precision: 10, scale: 6 }
  end
end
