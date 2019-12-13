class ArticlesController < ApplicationController
  # before_action :authenticate_user!, except: :index
  before_action :set_article, only:[:show, :edit, :update]
  
  def index
    @articles = Article.includes(:prefecture).order("created_at DESC")
    @prefectures = Prefecture.all
  end

  def list
    @list = Article.includes(:prefecture).length
    @articles = Article.includes(:prefecture).order("created_at DESC")
  end

  def list_search
    @spot_id = "#{params[:spot_id]}"
    if (@spot_id != "1") && (@spot_id != "47") && (@spot_id != "48") && (@spot_id != "49") && (@spot_id != "50") && (@spot_id != "51") && (@spot_id != "52") && (@spot_id != "53") && (@spot_id != "54") && (@spot_id != "55")
      @search_articles = Article.where(prefecture_id: @spot_id)
    else
      @spots = Prefecture.where(parent_id: @spot_id)
      @search_articles = Article.where(prefecture_id: @spots)
    end
  end  

  def show
    @picture = Picture.new
    @relation_prefectures = Article.where(prefecture: @article.prefecture).where('id != ?', @article.id).order("created_at DESC")
    @parent_prefecture = Prefecture.find(@article.prefecture.parent_id)
    @geocoder = Geocoder.coordinates(@article.title)
    if @geocoder != nil
      @lat = @geocoder[0]
      @lng = @geocoder[1]
    else
      @lat = @article.latitude
      @lng = @article.longitude
    end
  end
  
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to root_path
    else
      render "new"
    end
  end

  def update
    if @article.update(article_params)
      redirect_to article_path(id: @article.id), notice: "変更しました。"
    else
      render :show
    end
  end

  def destroy
    if article = Article.find_by(id: params[:id])
      article.destroy
    end
    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(
      :title,
      :detail,
      :image,
      :sub_image1,
      :sub_image2,
      :address,
      :latitude,
      :longitude,
      :prefecture_id
    )
  end

  def set_article
    @article = Article.find(params[:id])
  end

end
