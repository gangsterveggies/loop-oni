class Guide < ActiveRecord::Base
  include ActionView::Helpers::TextHelper

  has_many :guide_relationships, foreign_key: "guide_id", dependent: :destroy
  has_many :articles, -> { order("guide_relationships.position desc") }, :through => :guide_relationships, source: :article
  default_scope -> { order('title ASC') }
  validates :title, presence: true
  validates :description, presence: true

  def self.search(search, page)
    if search
      order("title ASC").paginate(page: page, per_page: 20, :conditions => ['title LIKE ?', "%#{search}%"])
    else
      order("title ASC").paginate(page: page, per_page: 20)
    end
  end

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
