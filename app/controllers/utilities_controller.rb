class UtilitiesController < ApplicationController
  respond_to :html, :json

  before_action :authenticate_user!

  def index
    @utilities = current_user.utilities.all

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @utility = current_user.utilities.find(params[:id])
    @bills = @utility.bills
  end

  def new
    @utility = current_user.utilities.new
  end

  def create
    @utility = Utility.new(utility_params)
    privilege = Privilege.new(
      user: current_user,
      utility: @utility,
      permission: 'owner'
    )

    if @utility.save && privilege.save
      redirect_to utilities_path
    else
      render :new
    end
  end

  def edit
    @utility = current_user.utilities.find(params[:id])
  end

  def update
    @utility = current_user.utilities.find(params[:id])
    if @utility.update_attributes(utility_params)
      redirect_to utilities_path
    else
      render :edit
    end
  end

  def destroy
    @utility = Utility.find(params[:id])
    @utility.destroy
    redirect_to utilities_path
  end

  private

  def utility_params
    params.require(:utility).permit(:name)
  end

end
