# -*- coding: utf-8 -*-
class SessionsController < ApplicationController
  before_action :not_signed_in_user, only: [:new]

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.email_validated_at < DateTime.now()
        flash.now[:alert] = 'Só é possível logar-se depois de validar o E-mail.'
        render 'new'
      else
        sign_in user
        redirect_back_or user
      end
    else
      flash.now[:error] = 'Combinação Username/Password errada...'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
