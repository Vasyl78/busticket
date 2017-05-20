class TicketsController < ApplicationController
  def index
  	@tickets = current_user.tickets
  end

  def new
  	@ticket = current_user.tickets.build
  end

  def create
  	@ticket = current_user.tickets.create(ticket_params)
  	if @ticket.errors.empty?
		redirect_to tickets_path, alert: @ticket.errors.full_messages.join("/n")
	else
		render "new"
	end  	
  end

  private

  def ticket_params
	params.require(:ticket).permit(:journey_id)
  end
end	