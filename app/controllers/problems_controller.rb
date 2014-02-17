class ProblemsController < ApplicationController
  before_action :admin_user, only: [:edit, :update, :create, :destroy]

  def show
    @problem = Problem.find(params[:id])
    if (params[:solution] == '1')
      @solution = true
    end
  end

  def new
    @problem = Problem.new
  end

  def index
    if params[:problem_tag]
      @problems = Problem.tagged_with(params[:problem_tag]).paginate(page: params[:page], per_page: 20)
      @tag = params[:problem_tag]
    else
      @problems = Problem.search(params[:search], params[:page])
      @tag = ""
    end
  end

  def create
    @problem = Problem.new(problem_params)
    if @problem.save
      flash[:success] = "Problema adicionado com sucesso!"
      redirect_to problem_path(@problem)
    else
      render 'new'
    end
  end

  def destroy
    Problem.find(params[:id]).destroy
    flash[:success] = "Problema Apagado!"
    redirect_to problems_path
  end

  def edit
    @problem = Problem.find(params[:id])
  end

  def update
    @problem = Problem.find(params[:id])
    if @problem.update_attributes(problem_params)
      flash[:success] = "Problema atualizado"
      redirect_to @problem
    else
      render 'edit'
    end
  end


  private
    def problem_params
      params.require(:problem).permit(:title, :link, :submit_link, :statement, :notes, :solution, :problem_tag_list)
    end
end
