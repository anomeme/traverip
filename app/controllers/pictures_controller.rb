class PicturesController < ApplicationController
  before_action :authenticate_user!, except: :index
  
  def index
    @pictures = Picture.order("created_at DESC")
  end

  def show
    @picture = Picture.new
    @article = Article.find(params[:id])
    @pictures = Picture.where(article_id: params[:id]).order("created_at DESC").page(params[:page]).per(8)
  end

  def main_image
    @main_image = Picture.find("#{params[:image_id]}")
  end

  def create
    url = request.referer
    @picture = Picture.create(picture_params)
    if @picture.save
      if url.include?("picture")
        redirect_to picture_path(id: @picture.article_id)
      else
        redirect_to article_path(id: @picture.article_id)
      end
    else
      render "new"
    end
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to user_path(id: current_user.id), notice: "削除完了"
  end


  private
  def picture_params
    params.require(:picture).permit(:title, :image, :article_id).merge(user_id: current_user.id)
  end

end
