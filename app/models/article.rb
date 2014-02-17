class Article < ActiveRecord::Base
  has_many :guide_relationships, foreign_key: "article_id", dependent: :destroy
  has_many :guides, -> { order("guide_relationships.position desc") }, :through => :guide_relationships, source: :guide
  has_many :read_relationships, foreign_key: "article_id", dependent: :destroy
  has_many :users_read, through: :read_relationships, source: :user
  validates :title, presence: true
  validates :content, presence: true
  acts_as_taggable_on :article_tag

  def self.search(search, page)
    if search
      order("title ASC").paginate(page: page, per_page: 20, :conditions => ['title LIKE ?', "%#{search}%"])
    else
      order("title ASC").paginate(page: page, per_page: 20)
    end
  end
end
