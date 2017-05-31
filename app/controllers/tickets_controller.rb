class TicketsController < ApplicationController
  def index
  	@tickets = current_user.tickets
  end

  def new
  	@ticket = current_user.tickets.build
  end

  def create
# Ticket.crate(params.merge(price: Journey.find(p[:id]).calculate_price(p[start_station_id], p[final_station_id]))

  	@ticket = current_user.tickets.create(ticket_params)
  	if @ticket.errors.empty?
  		redirect_to tickets_path
  	else
      flash.now[:alert] = @ticket.errors.full_messages
  		render 'new'
  	end  	
  end

  def journey_selection
    stations = Journey.find(params[:id]).stations.map { |station| { id: station.id, name: station.name } }

    respond_to do |format|
      format.json { render json: stations }
      
    end
  end

  def journey_info
   ways = Journey.find(params[:id]).routes
   # ways = ways.where("start_station_id >= :start_station_id AND final_station_id <= :final_station_id ", {start_station_id: params[:startStationId], final_station_id: params[:finalStationId]})
   # ways = ways.map { |route| { start_station_id: start_station_id.id, final_station_id: start_station_id.id,: route.name } }

   start_pos = ways.find_by(start_station_id: params[:startStationId])&.position
   final_pos = ways.find_by(final_station_id: params[:finalStationId])&.position

   if start_pos.nil? || final_pos.nil? || (start_pos..final_pos).to_a.empty?
    render json: { price: -1 }
  else
    price = ways.where(position: start_pos..final_pos).sum(:price)
    render json: { price: price }
  end




  end

  private

  def ticket_params
	  params.require(:ticket).permit(:journey_id, :start_station_id, :final_station_id)
  end
end	