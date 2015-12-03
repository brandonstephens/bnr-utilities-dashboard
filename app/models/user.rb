class User < ActiveRecord::Base
  has_many :privileges
  has_many :utilities, through: :privileges
  has_many :bills, through: :utilities
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
