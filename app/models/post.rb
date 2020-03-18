class Post < ApplicationRecord
  
  def user
    return User.find_by(id: self.user_id)
  end
  
  belongs_to :user
end
