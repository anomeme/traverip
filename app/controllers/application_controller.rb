class ApplicationController < ActionController::Base
  before_action :set_search
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth, if: :production?
  protect_from_forgery with: :exception  

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

  protected

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
