class BillsController < ApplicationController
  #protect_from_forgery with: :null_session, only: :create
  respond_to :html, :json

  before_action :authenticate_user!

  def index
    @bills = current_user.bills.all

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @bill = current_user.bills.find(params[:id])

    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @utilities = current_user.utilities.all
    utility_id = params[:utility_id]
    @bill = current_user.bills.new(utility_id: utility_id)
  end

  def create
    @utilities = current_user.utilities.all
    @bill = current_user.bills.new(bill_params)

    respond_to do |format|
       if @bill.save
         format.html { redirect_to @bill, flash: {success: 'Created bill'} }
         format.json { render json: @bill }
       else
         format.html { render :new, flash: {error: 'Could not create bill'}}
         format.json { render json: @bill, status: :unprocessable_entity }
       end
    end
  end

  def edit
    @utilities = current_user.utilities.all
    @bill = current_user.bills.find(params[:id])
  end

  def update
    @utilities = current_user.utilities.all
    @bill = current_user.bills.find(params[:id])

    if @bill.update_attributes(bill_params)
      flash[:success] = 'Updated Bill'
      redirect_to @bill
    else
      flash[:error] = 'Could not update bill'
      render :edit
    end
  end

  def destroy
    @bill = current_user.bills.find(params[:id])
    
    @bil.destroy

    respond_to do |format|
      if @bill.destroyed?
        format.html{ redirect_to bills_path, flash: {success: 'Deleted bill'} }
        format.json{ render json: @bill, status: 400 }
      else
        
      end
    end

    redirect_to bills_path
  end

  private

  def bill_params
    params.require(:bill).permit(:amount, :due_on, :utility_id)
  end
end
