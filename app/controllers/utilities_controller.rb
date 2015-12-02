class UtilitiesController < ApplicationController

  def index
    @utilities = Utility.all
  end

  def show
    @utility = Utility.find(params[:id])
  end

  def new
    @utility = Utility.new
  end

  def create
    @utility = Utility.new(utility_params)
    if @utility.save
      redirect_to utilities_path
    else
      render :new
    end
  end

  def edit
    @utility = Utility.find(params[:id])
  end

  def update
    @utility = Utility.find(params[:id])
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
