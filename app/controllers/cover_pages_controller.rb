class CoverPagesController < ApplicationController
  def home
    @posts = Post.paginate(page: params[:page], per_page: 20, :conditions => "id > 1")
    @fixed_post = Post.last
    @contests = Contest.all(:conditions => ["end_date >= ? AND begin_date <= ?", DateTime.now(), DateTime.now() + 1.month])
  end

  def help
  end
end
