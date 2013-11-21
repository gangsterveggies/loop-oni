# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Registado com sucesso!"
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
        if params[:user][:qualifications] or params[:user][:finals] or params[:user][:iois] or params[:user][:wins] or params[:user][:bronze] or params[:user][:silver] or params[:user][:gold]
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
      params.require(:user).permit(:name, :email, :grade, :school, :city, :profile_image, :password, :password_confirmation, :qualifications, :finals, :iois, :wins, :bronze, :silver, :gold)
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Tem de estar logado para continuar..."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless (current_user?(@user) or current_user.admin?)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
