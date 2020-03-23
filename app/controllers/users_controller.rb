class UsersController < ApplicationController
  
  before_action :authenticate_user!, only: [:profile_edit, :drafts, :favorite]
  
  def show
    @user = User.find_by(id: params[:id])
    @posts = Post.where(user: params[:id]).where(publish_flg: true).order(id: "DESC")
  end
  
  def drafts
    @posts_drafts = Post.where(user: current_user.id).where(publish_flg: false).order(id: "DESC")
    @posts_releas = Post.where(user: current_user.id).where(publish_flg: true).order(id: "DESC")
  end

  def favorite
    @posts_favorite = current_user.stocked_posts
  end
  
  def profile_edit
  end
  
end
