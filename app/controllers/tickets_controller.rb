class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
  end

  def create
    @ticket_type = TicketType.new(ticket_params)
    @ticket_type.event_id = params[:event_id]
    if @ticket_type.save
      flash.now[:error] = "Created tickets."
      # redirect_to event_tickets_path
    else
      flash.now[:error] = @ticket_type.errors.full_messages.to_sentence
    end
  end

  def index
    @ticket_type = TicketType.new
    #code
  end

  private
    def ticket_params
      params.require(:ticket_type).permit(:price, :name, :max_quantity)
      #code
    end
end
