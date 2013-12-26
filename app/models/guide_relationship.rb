class GuideRelationship < ActiveRecord::Base
  default_scope -> { order('position') }
  belongs_to :guide, class_name: "Guide"
  belongs_to :article, class_name: "Article"
  acts_as_list scope: :article
  validates :guide_id, presence: true
  validates :article_id, presence: true
end
