class Post < ApplicationRecord
  
  belongs_to :user
  
  has_many :stocks
  has_many :stocked_users, through: :stocks, source: :user
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  
  #いいね数の降順に並び替える
  def self.create_all_ranks
    Post.find(Like.group(:post_id).order('count(post_id) desc').pluck(:post_id))
  end
  
end
