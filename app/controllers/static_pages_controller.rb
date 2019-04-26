class StaticPagesController < ApplicationController

  def home
    @feed_items = current_user.feed.paginate(page: params[:page]) if current_user
  end

  def about
  end

  def tos
  end
end
