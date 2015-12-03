class BillMailer < ActionMailer::Base
  default from: "utilities-dashboard@bignerdranch.com"

  def export(user, csv)
    attachments['bills.csv'] = csv
    mail to: user.email, subject: 'You bills export is ready'
  end
end
