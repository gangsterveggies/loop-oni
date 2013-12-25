class GuideRelationship < ActiveRecord::Base
  belongs_to :guide, class_name: "Guide"
  belongs_to :article, class_name: "Article"
  validates :guide_id, presence: true
  validates :article_id, presence: true
end
