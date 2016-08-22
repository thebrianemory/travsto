class AddImagesToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :images, :json
  end
end
