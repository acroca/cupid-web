class Couple < ActiveRecord::Base
  attr_accessible :pretender_a, :pretender_b, :pretender_a_id, :pretender_b_id

  belongs_to :pretender_a, class_name: "Pretender"
  belongs_to :pretender_b, class_name: "Pretender"

  scope :for_pretenders, lambda { |pretender_1, pretender_2|
    for_pretender(pretender_1).for_pretender(pretender_2)
  }
  scope :for_pretender, lambda { |pretender|
    t = arel_table
    where(t[:pretender_a_id].eq(pretender.id).or(t[:pretender_b_id].eq(pretender.id)))
  }
end
