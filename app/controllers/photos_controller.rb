class PhotosController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :create, :destroy]
  before_action :correct_user, only: [:destroy]

  def index
    search_result = @q.result(distinct: true)
    show_result = search_result ||= Photo.all
    @feed_items = show_result.paginate(page: params[:page])
  end

  def show
    @photo = Photo.find(params[:id])
    @user = User.find(@photo.user_id)
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      flash[:success] = "Posted Photo!"
      redirect_to @photo
    else
      flash[:danger] = "Failed post Photo."
      @feed_items = []
      redirect_to root_path
    end
  end

  def destroy
    @photo.destroy
    flash[:success] = "Photo deleted"
    redirect_to current_user
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
