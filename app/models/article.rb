class Article < ActiveRecord::Base
  has_many :read_relationships, foreign_key: "article_id", dependent: :destroy
  has_many :users_read, through: :read_relationships, source: :user
  validates :title, presence: true
  validates :content, presence: true



  def self.search(search, page)
    if search
      paginate(page: page, per_page: 20, :conditions => ['title LIKE ?', "%#{search}%"])
    else
      paginate(page: page, per_page: 20)
    end
  end


end
