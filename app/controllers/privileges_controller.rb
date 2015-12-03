class PrivilegesController < ApplicationController

  def index
    @utility = Utility.find(params[:utility_id])
    @privileges = @utility.privileges
  end

  def new
    @utility = Utility.find(params[:utility_id])
    @privilege = @utility.privileges.new

    authorize @privilege
  end

  def create
    @utility = Utility.find(params[:utility_id])
    @privilege = @utility.privileges.new(privilege_params)

    authorize @privilege

    if @privilege.save
      flash[:success] = 'Created privilege'
      redirect_to utility_privileges_path(@utility)
    else
      flash[:error] = 'Could not create privilege'
      render :new
    end
  end

  def destroy
    @utility = Utility.find(params[:utility_id])
    @privilege = @utility.privileges.find(params[:id])

    authorize @privilege

    @privilege.destroy

    if @privilege.destroyed?
      flash[:success] = 'Deleted privilege'
      redirect_to utility_privileges_path(@utility)
    else
      flash[:error] = 'Could not delete privilege'
      render :new
    end
  end

  private

  def privilege_params
    params.require(:privilege).permit(:user_id, :permission)
  end

end