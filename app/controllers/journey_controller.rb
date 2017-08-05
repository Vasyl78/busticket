class JourneyController < ApplicationController

   def journey_selection
    stations = Journey.find(params[:id]).stations.map { |station| { id: station.id, name: station.name } }

    respond_to do |format|
      format.json { render json: stations }
     
   end
  end

  def journey_info
   ways = Journey.find(params[:id]).routes
   start_pos = ways.find_by(start_station_id: params[:startStationId])&.position
   final_pos = ways.find_by(final_station_id: params[:finalStationId])&.position

   if start_pos.nil? || final_pos.nil? || (start_pos..final_pos).to_a.empty?
    render json: { price: -1 }
   else
    price = ways.where(position: start_pos..final_pos).sum(:price)
    render json: { price: price }
   end
  end

end
