class GuidesController < ApplicationController
  before_action :admin_user, only: [:edit, :update, :create, :destroy]

  def show
    @guide = Guide.find(params[:id])
    @guide_articles = @guide.articles
  end

  def new
    @guide = Guide.new
  end

  def index
    @guides = Guide.search(params[:search], params[:page])
  end

  def create
    @guide = Guide.new(guide_params)
    if @guide.save
      flash[:success] = "Guia adicionado com sucesso!"
      redirect_to guide_path(@guide)
    else
      render 'new'
    end
  end

  def destroy
    Guide.find(params[:id]).destroy
    flash[:success] = "Guia Apagado!"
    redirect_to guides_path
  end

  def edit
    @guide = Guide.find(params[:id])
  end

  def update
    @guide = Guide.find(params[:id])
    if @guide.update_attributes(guide_params)
      flash[:success] = "Guia atualizado"
      redirect_to @guide
    else
      render 'edit'
    end
  end

  private
    def guide_params
      params.require(:guide).permit(:title, :description)
    end
end
