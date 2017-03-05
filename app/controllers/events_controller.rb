class EventsController < ApplicationController
  def index
    @events = Event.search(params[:search])
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    new_venue = Venue.new
    new_venue.name = params[:venues_name]
    new_venue.full_address = params[:venues_address]
    new_venue.region_id = params[:region_id]
    if !new_venue.save!
      p new_venue.errors.full_messages
      flash[:error] = "Error occur when adding venue."
      return
    end

    new_event = Event.new
    new_event.name = params[:name]
    new_event.category_id = params[:category_id]
    new_event.venue_id = new_venue.id
    new_event.hero_image_url = params[:image_url]
    new_event.starts_at = Time.strptime(params[:start_date], "%m/%d/%Y %H:%M %p")
    new_event.ends_at = Time.strptime(params[:end_date], "%m/%d/%Y %H:%M %p")
    new_event.extended_html_description = params[:content]
    if !new_event.save!
      flash[:error] = "Error occur when adding new event."
      return
    end

    flash[:success] = "Create event successfully!"
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
