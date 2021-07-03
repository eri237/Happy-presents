class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @item = Item.new
    @items = Item.all.order(created_at: :desc)
    if params[:age_want] != nil
      @items = Item.search_for(params[:age_want])
    end

  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    entity = Language.get_data(item_params[:name])
    # entity => { type: 'OTHER', hoge: 'huga' }
    @item.type = entity[:type]
    @item.entities_name = entity[:entities_name]
    @item.metadata = entity[:metadata]
    #@item.type = Language.get_data(item_params[:name])  #AI機能この行を追加
    #@item.entities_name = Language.get_data(item_params[:name, :description])  #AI機能この行を追加
    if @item.save
      redirect_to mypage_path(@item), notice: "You have created present successfully."
    else
      @items = Item.all
      render 'index'
    end
  end

  def show
    @item = Item.find(params[:id])
    @item_comment = ItemComment.new
    @user = @item.user
    @User = current_user
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    if @item.update(item_params)
    redirect_to mypage_path(@item), notice: "You have updated present successfully."
    else
    @items = Item.all
    render 'index'
    end
  end

  def destroy
    if @item.destroy
    redirect_to mypage_path(@item), notice: "「#{@item.name}」を削除しました"
    else
    render 'edit'
    end
  end

   private

  def item_params
    params.require(:item).permit(:name, :description, :image, :is_active, :age_want)
  end

  def ensure_correct_user
    @item = Item.find(params[:id])
    unless @item.user == current_user
      redirect_to items_path
    end
  end

end
