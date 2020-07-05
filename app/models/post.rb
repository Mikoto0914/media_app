class Post < ApplicationRecord
  
  belongs_to :user
 
  has_many :stocks
  has_many :likes
  has_many :comments,      dependent: :destroy
  has_many :tag_maps,      dependent: :destroy
  has_many :stocked_users, through:   :stocks, source: :user
  has_many :liked_users,   through:   :likes,  source: :user
  has_many :tags,          through:   :tag_maps
  
  
  validates :title,
            presence: true,
            length: { maximum: 50 }
            
  validates :content,
            presence: true,
            length: { maximum: 5000 }
            
  mount_uploader :thumbnail_image, ImageUploader
  
  #いいね数の降順に並び替える
  def self.create_like_ranks
    Post.find(Like.group(:post_id).order('count(post_id) desc').pluck(:post_id))
  end
  
  #入力されたキーワードをタイトル、記事内容、タグから探す
  def self.search(search)
    if search
      Post.eager_load(:tags).where(['title LIKE ? or content LIKE ? or tags.name LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])
    else
      Post.all
    end
  end
  
  #タグの名前を登録する
  def save_posts(savepost_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - savepost_tags
    new_tags = savepost_tags - current_tags

    #タグが登録されていれば登録しない
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end

    #タグが登録されていなければ新しく登録する
    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(name:new_name)
      self.tags << post_tag
    end
  end
end
