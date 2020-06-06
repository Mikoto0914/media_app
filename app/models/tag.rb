class Tag < ApplicationRecord
  has_many :tag_maps, dependent: :destroy
  has_many :posts,    through:   :tag_maps
  
  validates :name, presence: true, uniqueness: true, length: { maximum: 25 }
end
