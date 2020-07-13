class TagMap < ApplicationRecord
  belongs_to :post
  belongs_to :tag
  
  #タグのランキング（最大５件）
  def self.create_tag_ranks
    TagMap.group(:tag_id).limit(5).order('count(tag_id) desc').count
  end
end
