class BoatsController < ApplicationController
  before_action :find_boat, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @boats = Boat.all
    @search = params[:search]
    if @search.present?
      @city = @search["address"]
      @boats = Boat.where(address: @city)
    end
    @markers = @boats.geocoded.map do |boat|
      {
        lat: boat.latitude,
        lng: boat.longitude
     }
    end
  end

  def show
  end

  def new
    @boat = Boat.new
  end

  def create
    @boat = Boat.new(boat_params)
    @boat.user = current_user

    if @boat.save
      redirect_to boat_path(@boat)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @boat.update(boat_params)
    redirect_to boat_path(@boat)
  end

  def destroy
    @boat.destroy
    redirect_to boats_path
  end

  private

  def find_boat
    @boat = Boat.find(params[:id])
  end

  def boat_params
    params.require(:boat).permit(:name, :location, :description, :price, :user_id, :image)
  end
end
