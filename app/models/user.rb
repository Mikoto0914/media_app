class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :name,
            presence: true,
            length: { maximum: 16 },
            format: {
                with: /\A[a-z0-9]+\z/,
                message: 'は小文字英数字で入力してください'
            } 
  
  validates :profile, length: { maximum: 255 }
      
  #いいねをすでにしているのか判定
  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end
  
  #ストックをすでにしているのか判定
  def already_stocked?(post)
    self.stocks.exists?(post_id: post.id)
  end
  
  #ユーザの総いいね数（最大５件）
  def self.create_all_user_ranks
    User.joins(posts: :likes).group("posts.user_id").limit(5).order('count(post_id) desc').count
  end
  
  mount_uploader :image, ImageUploader
  
  has_many :posts, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :stocked_posts, through: :stocks, source: :post, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post, dependent: :destroy

end
