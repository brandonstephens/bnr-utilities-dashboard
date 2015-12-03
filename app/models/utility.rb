class Utility < ActiveRecord::Base
  has_many :bills, dependent: :destroy
  has_many :privileges, dependent: :destroy
end
