class HomesController < ApplicationController
  def show
    @bills = current_user.bills.order(:due_on).all if user_signed_in?
  end
end
