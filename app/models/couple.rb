class Couple < ActiveRecord::Base
  attr_accessible :pretender_a, :pretender_b

  belongs_to :pretender_a, class_name: "Pretender"
  belongs_to :pretender_b, class_name: "Pretender"

  scope :for_pretender, lambda { |pretender|
    t = arel_table
    where(t[:pretender_a_id].eq(pretender.id).or(t[:pretender_b_id].eq(pretender.id)))
  }
end
