class Pretender < ActiveRecord::Base
  attr_accessible :name

  def iterations_ago_with(pretender)
    Couple.for_pretenders(self, pretender).minimum(:iterations_ago)
  end
end
