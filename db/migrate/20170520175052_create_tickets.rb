class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.integer :user_id
      t.integer :journey_id
      t.integer :start_station_id
      t.integer :final_station_id      
      t.timestamps
    end
  end
end
