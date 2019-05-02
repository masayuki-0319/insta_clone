class PhotoCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @photo = Photo.find(params[:photo_id])
    PhotoComment.create!(commenter_id: params[:commenter_id],
                         photo_id: params[:photo_id],
                         comment: params[:photo_comment][:comment])
    redirect_to @photo
  end

  def destroy
    @photo = Photo.find(params[:id])
    PhotoComment.find_by(commenter_id: current_user.id, photo_id: @photo.id).destroy
    redirect_to @photo
  end
end
