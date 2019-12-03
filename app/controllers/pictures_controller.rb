class PicturesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_picture, only:[:edit, :update, :destroy]
  
  def index
    @pictures = Picture.order("created_at DESC")
  end
  
  def new
    @picture = Picture.new
    @article = Article.find_by(id: params[:format])
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
    @picture.destroy
    redirect_to root_path, notice: "削除完了"
  end


  private
  def picture_params
    params.require(:picture).permit(:title, :image, :article_id).merge(user_id: current_user.id)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end
end
