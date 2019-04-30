class StaticPagesController < ApplicationController

  def home
    if user_signed_in?
      following_photo = Photo.where("user_id IN (?)", current_user.following_ids)
      @feed_items = following_photo.paginate(page: params[:page])
    end
  end

  def about
  end

  def tos
  end
end
