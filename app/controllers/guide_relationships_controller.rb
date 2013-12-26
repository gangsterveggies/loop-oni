class GuideRelationshipsController < ApplicationController
  before_action :admin_user

  def create
    @article = Article.find(params[:guide_relationship][:article_id])
    @guide = Guide.find(params[:guide_relationship][:guide_id])
    @guide.include!(@article)
    redirect_to @guide
  end

  def destroy
    @guide_rel = GuideRelationship.find(params[:id])
    @article = Article.find(@guide_rel.article_id)
    @guide = Guide.find(@guide_rel.guide_id)
    @guide.remove!(@article)
    redirect_to @guide
  end

  def sort
    @guide = params[:guide][0]
    params[:article].each_with_index do |a_id, index|
      GuideRelationship.update_all({position: index+1}, {article_id: a_id, guide_id: @guide})
    end
    render nothing: true
  end
end
