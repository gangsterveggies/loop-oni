class ReadRelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @article = Article.find(params[:read_relationship][:article_id])
    current_user.read!(@article)
    respond_to do |format|
      format.html { redirect_to @article }
      format.js
    end
  end

  def destroy
    @article = ReadRelationship.find(params[:id]).article
    current_user.unread!(@article)
    respond_to do |format|
      format.html { redirect_to @article }
      format.js
    end
  end
end
