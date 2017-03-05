class EventsController < ApplicationController
  def index
    @events = Event.search(params[:search])
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    new_event = Event.new
    new_event.name = params[:name]
    new_event.category_id = params[:category_id]
    new_event.venue_id = params[:venue_id]
    new_event.hero_image_url = params[:picture_url]
    new_event.starts_at = Time.strptime(params[:start_date], "%m/%d/%Y %H:%M %p")
    new_event.ends_at = Time.strptime(params[:end_date], "%m/%d/%Y %H:%M %p")
    new_event.extended_html_description = params[:content]
    new_event.user_id = current_user.id
    if !new_event.save!
      flash[:error] = "Error occur when adding new event."
      return
    end

    flash[:success] = "Create event successfully!"
    redirect_to event_tickets_path(new_event.id)
  end

  def new
    @event = Event.new()
    @regions = Region.all
    @categories = Category.all
    @venues = Venue.all
  end

  def mine
    @events = Event.where(user_id: current_user.id).all
  end

  def edit
    @event = Event.find(params[:id])
    @regions = Region.all
    @categories = Category.all
    @venues = Venue.all
  end

  def publish
    @event = Event.find(params[:id])
    if !@event.ticket_types.nil?
      @event.update_attribute(:published_at, Time.now)
    else
      flash[:error] = "You have to add at least 1 ticket type."
    end
    redirect_to mine_events_path
  end

  private


end
