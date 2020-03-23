class StocksController < ApplicationController
    
    before_action :authenticate_user!
  
  def create
    @stock = current_user.stocks.create(post_id: params[:post_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @stock = Stock.find_by(post_id: params[:post_id], user_id: current_user.id)
    @stock.destroy
    redirect_back(fallback_location: root_path)
  end
  
end
