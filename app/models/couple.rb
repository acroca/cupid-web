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

  def self.all_iterations_ago
    return Thread.current["all_iterations_ago"] if Thread.current["all_iterations_ago"].present?

    last_couples = Couple.select('pretender_a_id, pretender_b_id, min(iterations_ago) as iterations_ago').group('pretender_a_id, pretender_b_id')
    Thread.current["all_iterations_ago"] = last_couples.all.inject({}) do |acc, couple|
      acc[couple.pretender_a_id] ||= {}
      acc[couple.pretender_b_id] ||= {}

      if acc[couple.pretender_a_id][couple.pretender_b_id].nil? || couple.iterations_ago < acc[couple.pretender_a_id][couple.pretender_b_id].to_i
        acc[couple.pretender_a_id][couple.pretender_b_id] = couple.iterations_ago
        acc[couple.pretender_b_id][couple.pretender_a_id] = couple.iterations_ago
      end

      acc
    end
  end
end
