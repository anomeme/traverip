class FavoritesController < ApplicationController

  def create
    @article = Article.find(params[:id])
    @favorite = Favorite.new(user_id: current_user.id, article_id: @article.id)
    if @favorite.save
      redirect_to @article
    else
      redirect_to @article
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @favorite = Favorite.find_by(user_id: current_user.id, article_id: @article.id)
      @favorite.delete
      redirect_to @article
    else
      redirect_to @article
    end
  end

end
