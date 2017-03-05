class VenuesController < ApplicationController

  def new
    @venue = Venue.new
    @regions = Region.all
  end

  def create
    @venue = Venue.new(name: params[:name], full_address: params[:full_address], region_id: params[:region_id])
    if !@venue.save!
      flash[:error] = @venue.errors.full_messages.to_sentence
      redirect_to new_venue_path
    else
      flash[:success] = "Creat venue successfully."
      redirect_to root_path
    end
  end
end
