class Utility < ActiveRecord::Base
  has_many :bills
  belongs_to :user
end
