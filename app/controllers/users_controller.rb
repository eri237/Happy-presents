class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @item = Item.new
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @items = @user.items
    @item = Item.new
  end

  def mypage
    @items = current_user.items.order(created_at: :desc)
    @item = Item.new
    @uesr = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "登録情報を編集しました"
      redirect_to mypage_path
    else @user.update(user_params)
        flash[:danger] = '登録情報の編集に失敗しました'
        render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    @user = current_user
    @user.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :icon_id, :gender, :birthday, :email)
  end

end
