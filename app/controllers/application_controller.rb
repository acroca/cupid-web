class ApplicationController < ActionController::Base
  protect_from_forgery

  after_filter do
    Thread.current["all_iterations_ago"] = nil
  end
end
