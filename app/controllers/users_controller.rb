class UsersController < ApplicationController
  
  before_action :authenticate_user!, only: [:profile_edit]
  
  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: params[:id])
  end
  
  def profile_edit
  end

end
