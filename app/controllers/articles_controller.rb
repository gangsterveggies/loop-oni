class ArticlesController < ApplicationController
  before_action :admin_user, only: [:new, :edit, :update, :create, :destroy]

  def show
    @article = Article.find(params[:id])
    if signed_in? and current_user.admin?
      @guide_rel = GuideRelationship.new
      @guide_rel.article_id = @article.id
      @guide_list = Guide.find_but(@article)
    else
      if @article.draft
        redirect_to articles_path
      end
    end
  end

  def new
    @article = Article.new
  end

  def index
    if params[:article_tag]
      if signed_in? and current_user.admin?
        @articles = Article.tagged_with(params[:article_tag]).paginate(page: params[:page], per_page: 20)
      else
        @articles = Article.tagged_with(params[:article_tag]).paginate(page: params[:page], per_page: 20).where(draft: false)
      end
      @tag = params[:article_tag]
    else
      if signed_in? and current_user.admin?
        @articles = Article.search(params[:search], params[:page])
      else
        @articles = Article.search(params[:search], params[:page]).where(draft: false)
      end
      @tag = ""
    end
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "Artigo adicionado com sucesso!"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def destroy
    Article.find(params[:id]).destroy
    flash[:success] = "Artigo Apagado!"
    redirect_to articles_path
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:success] = "Artigo atualizado"
      redirect_to @article
    else
      render 'edit'
    end
  end


  private
    def article_params
      params.require(:article).permit(:title, :content, :draft, :article_tag_list, :attach)
    end
end
