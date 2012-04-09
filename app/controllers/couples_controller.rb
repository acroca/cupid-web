class CouplesController < ApplicationController

  # POST /couples
  def create
    couple = Couple.new(params[:couple])

    respond_to do |format|
      if couple.save
        format.html { redirect_to root_path, notice: 'Couple was successfully created.' }
      else
        format.html { redirect_to root_path, alert: 'Error creating the couple.' }
      end
    end
  end

  # POST /couples/round
  def round
    unless Pretender.any_single?
      Couple.update_all("iterations_ago = iterations_ago + 1")
    end
    redirect_to root_path
  end
end
