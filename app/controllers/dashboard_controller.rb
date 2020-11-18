class DashboardController < ApplicationController
  def index
    @bookings = Booking.where(user_id: current_user)
    @boats = Boat.where(user_id: current_user)
  end
end
