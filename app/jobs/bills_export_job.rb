class BillsExportJob
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    csv = BillsExport.new(user.bills).to_csv
    BillMailer.export(user, csv).deliver
  end
end