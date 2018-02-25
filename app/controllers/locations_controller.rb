# frozen_string_literal: true

class LocationsController < ApplicationController
  before_action :logged_in_user, except: [:index]

  def index
    @locations = Location.all.order(:name).paginate(page: params[:page])
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      flash[:success] = 'location created'
      redirect_to locations_path
    else
      render 'new'
    end
  end

  def edit
    @location = Location.find_by(id: params[:id])
  end

  def update
    @location = Location.find_by(id: params[:id])
    if @location.update_attributes(location_params)
      flash[:success] = 'location updated'
      redirect_to locations_path
    else
      render 'edit'
    end
  end
  
  private

    def location_params
      params.require(:location).permit(:name, :location_type_id, :website, :post_code)
    end
end
