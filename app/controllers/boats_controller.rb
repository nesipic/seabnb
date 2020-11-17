class BoatsController < ApplicationController
  before_action :find_boat, only: [:show, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @boats = Boat.all
    @search = params[:search]
    if @search.present?
      @city = @search["location"]
      @boats = Boat.where(location: @city)
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

  private

  def find_boat
    @boat = Boat.find(params[:id])
  end

  def boat_params
    params.require(:boat).permit(:name, :location, :description, :price, :user_id, :image)
  end
end
