class Journey < ApplicationRecord
	belongs_to :bus
	has_many   :tickets
	has_many   :routes

	def name
		"#{routes.first.start_station.name} - #{routes.first.final_station.name}"
	end
end
