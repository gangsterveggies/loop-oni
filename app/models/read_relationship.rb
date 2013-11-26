class ReadRelationship < ActiveRecord::Base
  belongs_to :user, class_name: "User"
  belongs_to :article, class_name: "Article"
  validates :user_id, presence: true
  validates :article_id, presence: true
end
