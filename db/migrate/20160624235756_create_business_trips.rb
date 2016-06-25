class CreateBusinessTrips < ActiveRecord::Migration
  def change
    create_table :business_trips do |t|
      t.references :business, index: true, foreign_key: true
      t.references :trip, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
