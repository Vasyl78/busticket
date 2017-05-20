class CreateRoutes < ActiveRecord::Migration[5.0]
  def change
    create_table :routes do |t|
      t.integer  :journey_id
      t.float    :price
      t.date     :start_date
      t.time     :start_time
      t.date     :final_date
      t.time     :final_time
      t.integer  :start_station_id
      t.integer  :final_station_id
      t.timestamps
    end
    add_index :routes, :start_date
    add_index :routes, :start_station_id
  end
end
