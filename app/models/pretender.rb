class Pretender < ActiveRecord::Base
  attr_accessible :name, :disabled, :reserved

  scope :enabled, where(disabled: false)
  default_scope order("name ASC")

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

  def self.any_single?
    return true if Pretender.enabled.count != Couple.all_iterations_ago.keys.size
    Couple.all_iterations_ago.values.any? { |it_ago| !it_ago.values.include?(0) }
  end
end
