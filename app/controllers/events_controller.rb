class EventsController < ApplicationController
  def index
    if params[:search]
      @events = Event.search(params[:search])
    end
    @events = @events.upcoming
  end

  def show
    @event = Event.find(params[:id])
  end
end
