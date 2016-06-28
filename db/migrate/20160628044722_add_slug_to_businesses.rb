class AddSlugToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :slug, :string
    add_index :businesses, :slug, unique: true
  end
end
