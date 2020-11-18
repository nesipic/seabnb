class RemoveLocationFromBoats < ActiveRecord::Migration[6.0]
  def change
    remove_column :boats, :location, :string
  end
end
