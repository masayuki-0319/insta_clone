class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @photos = @user.photos.paginate(page: params[:page])
  end
end
