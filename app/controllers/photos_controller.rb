class PhotosController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :create, :destroy]
  before_action :correct_user, only: [:destroy]

  #課題：検索機能を実装する
  def index
    @feed_items = Photo.all.paginate(page: params[:page])
  end

  def show
    @user = User.find_by(params[:user_id])
    @photo = Photo.find(params[:id])
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      flash[:success] = "Photo created!"
      redirect_to @photo
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @photo.destroy
    flash[:success] = "Photo deleted"
    redirect_to request.referrer || root_url
  end

  private

    def photo_params
      params.require(:photo).permit(:picture, :title)
    end

    def correct_user
      @photo = current_user.photos.find_by(id: params[:id])
      redirect_to root_url if @photo.nil?
    end
end
