class AddAvailabilityFieldsToParkingLot < ActiveRecord::Migration[6.0]
  def change
    add_column :parking_lots, :total_lots, :integer
    add_column :parking_lots, :lots_available, :integer, default: 0
    add_column :parking_lots, :availability_updated_at, :datetime
  end
end
