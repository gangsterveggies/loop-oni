class ContestsController < ApplicationController
  require 'will_paginate/array'

  before_action :admin_user, only: [:edit, :update, :create, :destroy]

  def show
    @contest = Contest.find(params[:id])
  end

  def new
    @contest = Contest.new
  end

  def index
    @future_contests = Contest.paginate(page: params[:page], per_page: 20, :conditions => ["end_date > ?", DateTime.now()])

    @past_contests = []
    ini_year = 2012
    while (true)
      @cur = Contest.order("begin_date ASC").paginate(page: params[:page], per_page: 20, :conditions => ["end_date < ? AND end_date > ?", [Date.new(ini_year + 1, 9, 1), DateTime.now()].min, Date.new(ini_year, 9, 1)])
      if @cur.empty?
        break
      else
        @past_contests.push({:year => ini_year, :contests => @cur})
      end
      ini_year += 1
    end
    @past_contests = @past_contests.paginate(page: params[:page], per_page: 20)
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
