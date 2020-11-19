class DashboardController < ApplicationController
  def index
    @bookings = policy_scope(Booking).where(user_id: current_user)
    @boats = Boat.where(user_id: current_user)
    @boat_bookings = []
    Booking.all.each do |booking|
      @boat_bookings << booking if booking.boat.user == current_user
    end
  end
end
