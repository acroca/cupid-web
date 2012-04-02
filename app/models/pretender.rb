class Pretender < ActiveRecord::Base
  attr_accessible :name

  def iterations_ago_with(pretender)
    Couple.all_iterations_ago[self.id][pretender.id]
  end

  def has_couple?
    @has_couple ||= Couple.all_iterations_ago[self.id].values.min == 0
  end
end
