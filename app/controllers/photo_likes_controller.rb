class PhotoLikesController < ApplicationController
  before_action :authenticate_user!

#  def create
#    @photo = Photo.find_by(params[:id])
#    @current_user.like(@photo)
#    redirect_to root_path
#  end
#
#  def destroy
#    @photo = Photo.find(params[:id])
#    @current_user.unlike(@photo)
#    #@like = PhotoLike.find_by(liker_id: @current_user.id, post_id: @photo.id)
#    #@like.destroy
#    redirect_to root_path
#  end

  #課題０１：上記でコード実装が難航したため，実装したlike機能無視，具象化しすぎ，Ajax未稼働
  def create
    @like = PhotoLike.new(liker_id: @current_user.id, photo_id: params[:id])
    @like.save
    respond_to do |format|
      format.html { redirect_to photo_path(Photo.find(params[:id])) }
      format.js
    end
    #redirect_to photo_path(Photo.find(params[:id]))
  end

  def destroy
    @like = PhotoLike.find_by(liker_id: @current_user.id, photo_id: params[:id])
    @like.destroy
    respond_to do |format|
      format.html { redirect_to photo_path(Photo.find(params[:id])) }
      format.js
    end
    #redirect_to photo_path(Photo.find(params[:id]))
  end

end
