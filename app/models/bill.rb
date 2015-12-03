class Bill < ActiveRecord::Base
  belongs_to :utility
  has_one :user, through: :utility
end
