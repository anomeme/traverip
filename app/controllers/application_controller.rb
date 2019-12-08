class ApplicationController < ActionController::Base
  before_action :set_search
  def set_search
    words = params[:q].delete(:title_or_detail_cont) if params[:q].present?
    @word = words
    if words.present?
      params[:q][:groupings] = []
      words.split(/[ 　]/).each_with_index do |word, i|
        params[:q][:groupings][i] = { title_or_detail_cont: word }
      end
    end
    @q = Article.order("created_at DESC").page(params[:page]).per(10).ransack(params[:q])
    @articles = @q.result(distinct: true)
  end
end
