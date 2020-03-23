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
      
  #いいねをしているのか判定
  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end
  
  #ストックしているのか判定
  def already_stocked?(post)
    self.stocks.exists?(post_id: post.id)
  end
  
  mount_uploader :image, ImageUploader
  
  has_many :posts
  has_many :stocks
  has_many :stocked_posts, through: :stocks, source: :post
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post
  

end
