class EventsController < ApplicationController
  def index
    @events = Event.search(params[:search])
  end

  def show
    @event = Event.find(params[:id])
  end
end
