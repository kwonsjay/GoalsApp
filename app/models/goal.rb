class Goal < ActiveRecord::Base
  attr_accessible :title, :body, :author_id, :private
  validates :title, :body, :author_id, :presence => true

  belongs_to(
  :author,
  :class_name => "User",
  :foreign_key => :author_id,
  :primary_key => :id
  )

  has_many :cheers

end
