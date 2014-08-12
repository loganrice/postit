class Comment < ActiveRecord::Base
  include VoteableLoganAug
  
  belongs_to :user
  belongs_to :post
  
  validates :body, presence: true


end