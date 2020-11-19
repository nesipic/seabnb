class BoatsController < ApplicationController
  before_action :find_boat, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @boats = policy_scope(Boat)
    @search = params[:search]
    if @search.present?
      @city = @search["address"]
      @boats = @city.empty? ? Boat.all : Boat.where(address: @city)
    end
    @markers = @boats.geocoded.map do |boat|
      {
        lat: boat.latitude,
        lng: boat.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { boat: boat })
      }
    end
  end

  def show
    @booking = Booking.new
    authorize @boat
  end

  def new
    @boat = Boat.new
    authorize @boat
  end

  def create
    @boat = Boat.new(boat_params)
    authorize @boat
    authorize current_user
    @boat.user = current_user

    if @boat.save
      redirect_to boat_path(@boat)
    else
      render :new
    end
  end

  def edit
    authorize @boat
  end

  def update
    authorize @boat
    @boat.update(boat_params)
    redirect_to boat_path(@boat)
  end

  def destroy
    authorize @boat
    @boat.destroy
    redirect_to dashboard_path
  end

  private

  def find_boat
    @boat = Boat.find(params[:id])
  end

  def boat_params
    params.require(:boat).permit(:name, :address, :description, :price, :user_id, :image)
  end
end
