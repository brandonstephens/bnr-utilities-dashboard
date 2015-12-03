class HomesController < ApplicationController
  def show
    @bills = Bill.order(:due_on).all if user_signed_in?
  end
end
