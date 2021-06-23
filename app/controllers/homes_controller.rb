class HomesController < ApplicationController

  def top
    @items = Item.all.order(created_at: :desc)
    @user = current_user

    # フォームから値が飛んでるのかチェック
    if params[:age_want] != nil
      @items = Item.search_for(params[:age_want])
    end

  end

  def about
  end

end
