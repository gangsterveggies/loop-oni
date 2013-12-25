class Guide < ActiveRecord::Base
  include ActionView::Helpers::TextHelper

  has_many :guide_relationships, foreign_key: "guide_id", dependent: :destroy
  has_many :articles, :through => :guide_relationships, source: :article
  default_scope -> { order('title ASC') }
  validates :title, presence: true
  validates :description, presence: true

  def truncate_title
    truncate(title, :length => 24)
  end

  def include?(article)
    guide_relationships.find_by(article_id: article.id)
  end

  def include!(article)
    guide_relationships.create!(article_id: article.id)
  end

  def remove!(article)
    guide_relationships.find_by(article_id: article.id).destroy!
  end

  def self.find_but(article)
    all(:conditions => ["id NOT IN (?)", article.guide_ids.join(', ')])
  end
end
