class UsersController < ApplicationController
  
  before_action :authenticate_user!, only: [:drafts, :favorite, :profile_edit]
  
  def show
    @user = User.find_by(id: params[:id])
    @posts_latest = article_extraction(params[:id], true)
    @my_ranks = Post.create_all_ranks.select{ |post| post.user_id == @user.id && post.publish_flg==true }
    
    @posts_my_ranks = Kaminari.paginate_array(@my_ranks).page(params[:page]).per(20)
    @posts_likes = @user.liked_posts.page(params[:page]).per(20)
  end
  
  def draft
    @posts_draft = article_extraction(current_user.id, false)
    @posts_release = article_extraction(current_user.id, true)
  end

  def favorite
    @posts_favorite = current_user.stocked_posts.page(params[:page]).per(20)
  end
  
  def profile_edit
  end
  
  def article_extraction(user_id, flg)
    return Post.where(user: user_id).where(publish_flg: flg).order(updated_at: "DESC").page(params[:page]).per(20)
  end
  
end
