class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  validates :username, presence: true, uniqueness: true
  has_secure_password validations: false
  
end