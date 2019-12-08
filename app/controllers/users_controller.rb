class UsersController < ApplicationController
  before_action :set_user

  def show
  end

  def update
    if @user.update(edit_user)
      redirect_to user_path(id: current_user.id), notice: "変更しました。"
    else
      render :show
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def edit_user
    params.require(:user).permit(:avatar, :profile)
  end

end
