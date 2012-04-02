class DashboardController < ApplicationController
  def show
    @pretenders = Pretender.all
  end
end
