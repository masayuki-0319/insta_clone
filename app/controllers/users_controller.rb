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
    @like_photos = Photo.where(id: @user.photo_likes.map { |p| p.photo_id })
    render 'show_like'
  end
end
