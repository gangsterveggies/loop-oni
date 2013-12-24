# -*- coding: utf-8 -*-
class AnnouncementsController < ApplicationController
  before_action :admin_user, only: [:edit, :update, :create, :destroy]

  def new
    @announcement = Announcement.new
  end

  def index
    @announcements = Announcement.paginate(page: params[:page], per_page: 20)
  end

  def create
    @announcement = Announcement.new(announcement_params)
    if @announcement.save
      flash[:success] = "Notificação adicionada com sucesso!"
      redirect_to announcements_path
    else
      render 'new'
    end
  end

  def destroy
    Announcement.find(params[:id]).destroy
    flash[:success] = "Notificação apagada!"
    redirect_to announcements_path
  end

  def edit
    @announcement = Announcement.find(params[:id])
  end

  def update
    @announcement = Announcement.find(params[:id])
    if @announcement.update_attributes(announcement_params)
      flash[:success] = "Notificação atualizada"
      redirect_to announcements_path
    else
      render 'edit'
    end
  end


  private
    def announcement_params
      params.require(:announcement).permit(:message, :begin_date, :end_date)
    end
end
