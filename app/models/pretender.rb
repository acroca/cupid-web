class Pretender < ActiveRecord::Base
  attr_accessible :name

  def iterations_ago_with(pretender)
    all_iterations = Couple.all_iterations_ago[self.id]
    return nil if all_iterations.blank?
    all_iterations[pretender.id]
  end

  def has_couple?
    all_iterations = Couple.all_iterations_ago[self.id]
    return false if all_iterations.blank?
    all_iterations.values.min == 0
  end
end
