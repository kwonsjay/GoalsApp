class Cheer < ActiveRecord::Base
  attr_accessible :user_id, :goal_id
  validates :user_id, :goal_id, :presence => true

  belongs_to :user
  belongs_to :goal

end
