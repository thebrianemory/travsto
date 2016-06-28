class AddSlugToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :slug, :string
    add_index :trips, :slug, unique: true
  end
end
