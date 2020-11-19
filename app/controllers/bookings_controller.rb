class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  def show
    authorize @booking
  end

  def new
    @booking = Booking.new
    authorize @booking
    @boat = Boat.find(params[:boat_id])
  end

  def create
    @boat = Boat.find(params[:boat_id])
    @booking = Booking.new(booking_params)
    authorize @booking
    @booking.boat = @boat
    @booking.user = current_user
    if @booking.save
      redirect_to confirmation_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    authorize @booking
    @booking.update(booking_params)
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  def destroy
    authorize @booking
    @booking.destroy
    redirect_to dashboard_path
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
