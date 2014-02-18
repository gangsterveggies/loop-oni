# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def show
    @user = User.find(params[:id])
    @signed_contests = @user.participate_contests.where("begin_date >= ?", DateTime.now)
    @done_contests = @user.participate_contests.where("begin_date < ?", DateTime.now)
    @any_social = (!(@user.topcoder.nil? or @user.topcoder.empty?)) || (!(@user.codeforces.nil? or @user.codeforces.empty?)) || (!(@user.blog.nil? or @user.blog.empty?));
  end

  def new
    @user = User.new
  end

  def index
    @current_users = User.order("name ASC").paginate(page: params[:page], per_page: 20, :conditions => ["email_validated_at < ? AND graduation_year >= ?", DateTime.now(), get_current_graduation_year()])
    @past_users = User.order("name ASC").paginate(page: params[:page], per_page: 20, :conditions => ["email_validated_at < ? AND graduation_year < ?", DateTime.now(), get_current_graduation_year()])
  end

  def create
    @user = User.new(user_params)
    @user.updating_password = true
    if @user.save
      @user.send_email_validation
      flash[:success] = "Registado com sucesso! Um email foi enviado para validar o e-mail introduzido."
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Conta apagada!"
    redirect_to root_path
  end

  def edit
    @user = User.find(params[:id])
    @user.grade = get_grade_from_year(@user.graduation_year)
    if params[:form] == "image"
      render 'edit_image'
    elsif params[:form] == "password"
      render 'edit_password'
    end
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:profile_image]
      params[:user][:grade] = get_grade_from_year(@user.graduation_year)
      if @user.update_attributes(user_params)
        flash[:success] = "Imagem atualizada"
        redirect_to @user
      else
        render 'edit_image'
      end
    elsif params[:user][:password]
      @user.updating_password = true
      params[:user][:grade] = get_grade_from_year(@user.graduation_year)
      if @user && @user.authenticate(params[:user][:old_password])
        if @user.update_attributes(user_params)
          flash[:success] = "Password atualizada"
          redirect_to @user
        else
          render 'edit_password'
        end
      else
        flash.now[:error] = 'Password antiga errada...'
        render 'edit_password'
      end
    else
      if !current_user.admin?
        if params[:user][:qualifications] or params[:user][:finals] or params[:user][:iois] or params[:user][:wins] or params[:user][:bronze] or params[:user][:silver] or params[:user][:gold] or params[:user][:email]
          flash[:error] = "Não tem permissões para alterar alguns dos parametros"
          redirect_to @user and return
        end
      end
      if @user.update_attributes(user_params)
        flash[:success] = "Conta atualizada"
        redirect_to @user
      else
        render 'edit'
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :grade, :school, :city, :profile_image, :password, :password_confirmation, :qualifications, :finals, :iois, :wins, :bronze, :silver, :gold, :blog, :codeforces, :topcoder)
    end
end
