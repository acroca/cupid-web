class CouplesController < ApplicationController

  # POST /couples
  # POST /couples.json
  def create
    couple = Couple.new(params[:couple])

    respond_to do |format|
      if couple.save
        format.html { redirect_to root_path, notice: 'Couple was successfully created.' }
        format.json { render json: couple, status: :created }
      else
        format.html { redirect_to root_path, alert: 'Error creating the couple.' }
        format.json { render json: couple.errors, status: :unprocessable_entity }
      end
    end
  end

end
