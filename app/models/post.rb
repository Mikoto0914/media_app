class Post < ApplicationRecord
  
  belongs_to :user
  
  has_many :stocks
  has_many :stocked_users, through: :stocks, source: :user
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  
end
