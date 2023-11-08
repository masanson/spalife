class Public::HomesController < ApplicationController
  def top
    @hot_posts = HotPost.order('id DESC').limit(4)
  end

  def about
  end
end
