class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(edit_user)
      redirect_to user_path(id: current_user.id), notice: "変更しました。"
    else
      render :show
    end
  end

  def favorite
    @favorites = Favorite.where(user_id: current_user.id).each_slice(2).map(&:first)
  end

  private

  def edit_user
    params.require(:user).permit(:avatar, :profile)
  end

end
