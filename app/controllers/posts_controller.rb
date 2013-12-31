class PostsController < ApplicationController
  before_action :admin_user, only: [:new, :edit, :update, :create, :destroy]

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post adicionado com sucesso!"
      redirect_to @post
    else
      render 'new'
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = "Post Apagado!"
    redirect_to posts_path
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "Post atualizado"
      redirect_to @post
    else
      render 'edit'
    end
  end


  private
    def post_params
      params.require(:post).permit(:title, :content)
    end
end
