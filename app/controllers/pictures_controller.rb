class PicturesController < ApplicationController
  before_action :authenticate_user!, except: :index
  
  def index
    @pictures = Picture.order("created_at DESC")
  end

  def create
    @picture = Picture.create(picture_params)
    if @picture.save
      redirect_to article_path(id: @picture.article_id)
    else
      render "new"
    end
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to root_path, notice: "削除完了"
  end


  private
  def picture_params
    params.require(:picture).permit(:title, :image, :article_id).merge(user_id: current_user.id)
  end
  
end
