class Journey < ApplicationRecord
	belongs_to :bus
	has_many   :tickets
	has_many   :routes

	def name
		"#{routes.first.start_station.name} - #{routes.last.final_station.name}" rescue 'New Journey'
	end

	def stations
		routes.order(:position).map(&:start_station) + [routes.order(:position).last.final_station]
	end

	# def calculate_price(params[:ticket][:start_station_id], params[:ticket][:final_station_id])
	# 	start_pos = ways.find_by(start_station_id: params[:startStationId])&.position
 # 		final_pos = ways.find_by(final_station_id: params[:finalStationId])&.position
	# 	if start_pos.nil? || final_pos.nil? || (start_pos..final_pos).to_a.empty? 
	# 		price = -1			
	# 	else
	# 		price = Journey.find(p[:id]).calculate_price(p[start_station_id], p[final_station_id])			
	# 	end
	# end
	
end
