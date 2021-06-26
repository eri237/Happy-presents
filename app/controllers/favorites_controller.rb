class FavoritesController < ApplicationController
   before_action :authenticate_user!

  def create
    @item = Item.find(params[:item_id])
    unless @item.favorited_by?(current_user)
      favorite = current_user.favorites.new(item_id: @item.id)
      favorite.save
    end
    # redirect_to request.referer　非同期通信のためさくじょ
  end

  def destroy
    @item = Item.find(params[:item_id])
    favorite = current_user.favorites.find_by(item_id: @item.id)
    favorite.destroy
    # redirect_to request.referer 非同期通信のためさくじょ
  end
end