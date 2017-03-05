class EventsController < ApplicationController
  def index
    @events = Event.search(params[:search])
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    p params
    redirect_to root_path
  end

  def new
    @event = Event.new()
    @regions = Region.all
    @categories = Category.all
  end

  private

    def event_params
      params.require(:event).permit(:start_at, :end_at, :venue_id, :hero_image_url, :category_id, :name)
    end
end
