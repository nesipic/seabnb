class DashboardController < ApplicationController
  def index
    @bookings = policy_scope(Booking).where(user_id: current_user)
    @boats = Boat.where(user_id: current_user)
  end
end
