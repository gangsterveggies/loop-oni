class ContestsController < ApplicationController
  before_action :admin_user, only: [:edit, :update, :create, :destroy]

  def show
    @contest = Contest.find(params[:id])
  end

  def new
    @contest = Contest.new
  end

  def index
    @contests = Contest.paginate(page: params[:page], per_page: 20)
  end

  def create
    @contest = Contest.new(contest_params)
    if @contest.save
      flash[:success] = "Concurso adicionado com sucesso!"
      redirect_to contest_path(@contest)
    else
      render 'new'
    end
  end

  def destroy
    Contest.find(params[:id]).destroy
    flash[:success] = "Concurso Apagado!"
    redirect_to contests_path
  end

  def edit
    @contest = Contest.find(params[:id])
  end

  def update
    @contest = Contest.find(params[:id])
    if @contest.update_attributes(contest_params)
      flash[:success] = "Concurso atualizado"
      redirect_to @contest
    else
      render 'edit'
    end
  end


  private
    def contest_params
      params.require(:contest).permit(:title, :topic, :link, :duration, :description, :begin_date, :end_date)
    end
end
