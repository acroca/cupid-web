class DashboardController < ApplicationController
  def show
    @pretenders = Pretender.all
    @couples = Couple.where(iterations_ago: 0)
  end
end
