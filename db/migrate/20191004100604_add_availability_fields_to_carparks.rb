class AddAvailabilityFieldsToCarparks < ActiveRecord::Migration[6.0]
  def change
    add_column :carparks, :total_lots, :integer
    add_column :carparks, :lots_available, :integer, default: 0
    add_column :carparks, :availability_updated_at, :datetime
  end
end
