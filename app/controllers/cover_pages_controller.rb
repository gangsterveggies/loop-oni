class CoverPagesController < ApplicationController
  def home
    @posts = Post.paginate(page: params[:page], per_page: 20, :conditions => "id > 1")
    @fixed_post = Post.last
  end

  def help
  end
end
