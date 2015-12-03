class ExportRequestsController < ApplicationController

  def create
    csv = BillsExport.new(current_user.bills).to_csv
    BillMailer.export(current_user, csv).deliver
    flash[:success] = 'Your export will be delivered via email'
    redirect_to bills_path
  end

end