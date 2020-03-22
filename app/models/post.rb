class Post < ApplicationRecord
  
  belongs_to :user
  has_many :stocks
  has_many :stock_users, through: :stocks, source: :user
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  
  # 現在ログインしているユーザーidを受け取り、記事をストックする
  def stock(user)
    stocks.create(user_id: user.id)
  end

  # 現在ログインしているユーザーidを受け取り、記事のストックを解除する
  def unstock(user)
    stocks.find_by(user_id: user.id).destroy
  end

  # 記事がストック済みであるかを判定
  # 取得済みであれば true を返す
  def stocked?(user)
    stock_users.include?(user)
  end
  
end
