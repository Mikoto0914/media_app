class UsersController < ApplicationController
  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: params[:id])
  end
  
  def profile_edit
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduce, :image )
  end
end
