class Route < ApplicationRecord
	belongs_to :journey, required: false
	belongs_to :start_station, class_name: 'Station'
	belongs_to :final_station, class_name: 'Station'
end
