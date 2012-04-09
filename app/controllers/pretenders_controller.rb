class PretendersController < ApplicationController
  # GET /pretenders
  # GET /pretenders.json
  def index
    @pretenders = Pretender.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pretenders }
    end
  end

  # GET /pretenders/1
  # GET /pretenders/1.json
  def show
    @pretender = Pretender.find(params[:id])
    @couples = Couple.for_pretender(@pretender).order(:iterations_ago)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pretender }
    end
  end

  # GET /pretenders/new
  # GET /pretenders/new.json
  def new
    @pretender = Pretender.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pretender }
    end
  end

  # GET /pretenders/1/edit
  def edit
    @pretender = Pretender.find(params[:id])
  end

  # POST /pretenders
  # POST /pretenders.json
  def create
    @pretender = Pretender.new(params[:pretender])

    respond_to do |format|
      if @pretender.save
        format.html { redirect_to pretenders_url, notice: 'Pretender was successfully created.' }
        format.json { render json: @pretender, status: :created, location: @pretender }
      else
        format.html { render action: "new" }
        format.json { render json: @pretender.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pretenders/1
  # PUT /pretenders/1.json
  def update
    @pretender = Pretender.find(params[:id])

    respond_to do |format|
      if @pretender.update_attributes(params[:pretender])
        format.html { redirect_to pretenders_url, notice: 'Pretender was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pretender.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pretenders/1
  # DELETE /pretenders/1.json
  def destroy
    @pretender = Pretender.find(params[:id])
    @pretender.destroy

    respond_to do |format|
      format.html { redirect_to pretenders_url }
      format.json { head :no_content }
    end
  end
end
