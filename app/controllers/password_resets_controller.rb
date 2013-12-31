# -*- coding: utf-8 -*-
class PasswordResetsController < ApplicationController
  before_action :not_signed_in_user

  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    user.send_password_reset if user
    flash[:notice] = "Foi enviado um e-mail com instruções para repor a Password."
    redirect_to root_url
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    @user.updating_password = true
    if @user.password_reset_sent_at < 2.hours.ago
      flash[:alert] = "O link de reposição de Password expirou..."
      redirect_to new_password_reset_path
    elsif @user.update_attributes(user_params)
      @user.password_reset_sent_at = DateTime.now() - 3.hours
      @user.save!
      flash[:success] = "A Password foi reposta com sucesso!"
      redirect_to root_url
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
