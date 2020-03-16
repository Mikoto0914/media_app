class UsersController < ApplicationController
  
  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
  end
end
