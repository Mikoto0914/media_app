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
  
  def posts
    return Post.where(user_id: self.id)
  end
  
  mount_uploader :image, ImageUploader
  has_many :posts

end
