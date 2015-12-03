class BillsController < ApplicationController

  #protect_from_forgery with: :null_session, only: :create

  def index
    @bills = Bill.all

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @bill = Bill.find(params[:id])

    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @utilities = Utility.all
    utility_id = params[:utility_id]
    @bill = Bill.new(utility_id: utility_id)
  end

  def create
    @utilities = Utility.all
    @bill = Bill.new(bill_params)

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
