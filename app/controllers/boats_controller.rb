class BoatsController < ApplicationController
  before_action :find_boat, only: [:show, :destroy]
  def index
    @boats = Boat.all
  end
  def show
  end

  def new
    @boat = Boat.new
  end

  def create
    @boat = Boat.new(boat_params)
    user = current_user
    @boat.user = user
    
    
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
    params.require(:boat).permit(:name, :location, :description, :price, :user_id)
  end
end
