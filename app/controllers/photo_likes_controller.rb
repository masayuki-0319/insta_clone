class PhotoLikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = PhotoLike.new(liker_id: @current_user.id, photo_id: params[:id])
    @like.save
    respond_to do |format|
      format.html { redirect_to photo_path(Photo.find(params[:id])) }
      format.js
    end
  end

  def destroy
    @like = PhotoLike.find_by(liker_id: @current_user.id, photo_id: params[:id])
    @like.destroy
    respond_to do |format|
      format.html { redirect_to photo_path(Photo.find(params[:id])) }
      format.js
    end
  end
end
