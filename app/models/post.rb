class Post < ApplicationRecord
  
  belongs_to :user
  
  has_many :stocks
  has_many :stocked_users, through: :stocks, source: :user
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  
  validates :title,
            presence: true,
            length: { maximum: 50 }
  
  #いいね数の降順に並び替える
  def self.create_all_ranks
    Post.find(Like.group(:post_id).order('count(post_id) desc').pluck(:post_id))
  end
  
  #入力された値をタイトル、記事内容から探す
  def self.search(search)
    return Post.all unless search
    Post.where(['title LIKE ? or content LIKE ?', "%#{search}%", "%#{search}%"])
  end
  
end
