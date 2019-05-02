class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @photos = @user.photos.paginate(page: params[:page])
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def like
    @title = "Likes"
    @user = User.find(params[:id])
    photos = Photo.find(@user.photo_likes.ids)
    @like_photos = photos
    render 'show_like'
  end
end
