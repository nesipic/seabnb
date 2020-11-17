class AddImageToBoats < ActiveRecord::Migration[6.0]
  def change
    add_column :boats, :image, :string
  end
end
