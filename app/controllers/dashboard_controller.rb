class DashboardController < ApplicationController
  def show
    @pretenders = Pretender.enabled
    @couples = Couple.where(iterations_ago: 0).includes(:pretender_a, :pretender_b)
  end
end
