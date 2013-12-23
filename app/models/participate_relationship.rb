class ParticipateRelationship < ActiveRecord::Base
  belongs_to :user, class_name: "User"
  belongs_to :contest, class_name: "Contest"
  validates :user_id, presence: true
  validates :contest_id, presence: true
end
