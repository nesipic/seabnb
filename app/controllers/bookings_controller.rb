class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  def show
  end

  def new
    @booking = Booking.new
    @boat = Boat.find(params[:boat_id])
  end

  def create
    @boat = Boat.find(params[:boat_id])
    @booking = Booking.new(booking_params)
    @booking.boat = @boat
    @booking.user = current_user
    if @booking.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @booking.update(booking_params)
    if @booking.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @booking.destroy
    redirect_to root_path
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
