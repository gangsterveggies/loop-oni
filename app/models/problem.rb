class Problem < ActiveRecord::Base
  validates :title, presence: true
  acts_as_taggable_on :problem_tag

  def self.search(search, page)
    if search
      order("title ASC").paginate(page: page, per_page: 20, :conditions => ['title LIKE ?', "%#{search}%"])
    else
      order("title ASC").paginate(page: page, per_page: 20)
    end
  end
end
