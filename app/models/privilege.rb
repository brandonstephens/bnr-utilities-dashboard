class Privilege < ActiveRecord::Base
  belongs_to :utility
  belongs_to :user

  enum permission: [:read, :read_write, :owner]
end
