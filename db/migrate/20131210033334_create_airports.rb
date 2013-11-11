class CreateAirports < ActiveRecord::Migration
  def change
    create_table :airports do |t|
      t.string  :icao
      t.string  :name
      t.float   :lat
      t.float   :lon
      t.integer :elevation
      t.float   :magvar
      t.timestamps
    end
  end
end
