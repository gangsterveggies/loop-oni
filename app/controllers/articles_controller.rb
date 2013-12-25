class ArticlesController < ApplicationController
  before_action :admin_user, only: [:edit, :update, :create, :destroy]

  def show
    @article = Article.find(params[:id])
    @guide_rel = GuideRelationship.new
    @guide_rel.article_id = @article.id
    @guide_list = Guide.find_but(@article)
  end

  def new
    @article = Article.new
  end

  def index
    @articles = Article.search(params[:search], params[:page])
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
      params.require(:article).permit(:title, :content)
    end
end
