class BillsController < ApplicationController
  def index
    @bills = Bill.all
  end

  def show
    @bill = Bill.find(params[:id])
  end

  def new
    @utilities = Utility.all
    utility_id = params[:utility_id]
    @bill = Bill.new(utility_id: utility_id)
  end

  def create
    @utilities = Utility.all
    @bill = Bill.new(bill_params)

    if @bill.save
      redirect_to @bill
    else
      render :new
    end
  end

  def edit
    @utilities = Utility.all
    @bill = Bill.find(params[:id])
  end

  def update
    @utilities = Utility.all
    @bill = Bill.find(params[:id])

    if @bill.update_attributes(bill_params)
      flash[:success] = 'Updated Bill'
      redirect_to @bill
    else
      flash[:error] = 'Could not update bill'
      render :edit
    end
  end

  def destroy
    @bill = Bill.find(params[:id])
    @bil.destroy
    redirect_to bills_path
  end

  private

  def bill_params
    params.require(:bill).permit(:amount, :due_on, :utility_id)
  end
end
