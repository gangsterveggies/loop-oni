# -*- coding: utf-8 -*-
class EmailValidationsController < ApplicationController
  def edit
    @user = User.find_by_email_validation_token!(params[:id])
    @user.email_validated_at = DateTime.now()
    @user.save!
    flash[:success] = "Validação de email concluída com sucesso!"
    sign_in @user
    redirect_back_or @user
  end
end
