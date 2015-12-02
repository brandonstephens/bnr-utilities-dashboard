class HomesController < ApplicationController
  def show
    @bills = Bill.order(:due_on).all
  end
end
