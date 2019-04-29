class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :post_photo_prepare, if: :current_user
  before_action :prepare_photo_search

  def prepare_photo_search
    @q = Photo.ransack(params[:q])
  end

  private

    def post_photo_prepare
      @photo = current_user.photos.build
    end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :pen_name])
    end
end
