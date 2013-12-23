class Contest < ActiveRecord::Base
  has_many :participate_relationships, foreign_key: "contest_id", dependent: :destroy
  has_many :users_participate, through: :participate_relationships, source: :user
  validates :title, presence: true
  validates :topic, presence: true
  default_scope -> { order('begin_date ASC') }
end
