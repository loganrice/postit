class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create

  has_secure_password validations: false

  sluggable_column :username

  def admin?
    self.role.to_s == 'admin'
  end

  def moderator?
    self.role == 'moderator?'
  end

end