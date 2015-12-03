class ExportRequestsController < ApplicationController

  def create
    BillsExportJob.perform_async(current_user.id)
    flash[:success] = 'Your export will be delivered via email'
    redirect_to bills_path
  end

end