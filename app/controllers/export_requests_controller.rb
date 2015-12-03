class ExportRequestsController < ApplicationController

  def create
    csv = BillsExport.new(current_user.bills).to_csv
    render plain: csv
  end

end