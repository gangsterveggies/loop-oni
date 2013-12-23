class Contest < ActiveRecord::Base
  validates :title, presence: true
  validates :topic, presence: true
  default_scope -> { order('begin_date ASC') }
end
