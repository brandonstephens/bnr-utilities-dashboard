require 'csv'

class BillsExport
  HEADERS = ['utility', 'amount', 'due on'].freeze

  attr_reader :bills

  def initialize(bills)
    @bills = bills
  end

  def to_csv
    CSV.generate do |csv|
      csv << HEADERS
      bills.each do |bill|
        csv << [bill.utility.name, bill.amount, bill.due_on]
      end
    end
  end
end