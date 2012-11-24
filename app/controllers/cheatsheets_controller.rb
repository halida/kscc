class CheatsheetsController < ApplicationController
  # GET /cheatsheets
  # GET /cheatsheets.json
  def index
    @cheatsheets = Cheatsheet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cheatsheets }
    end
  end

  # GET /cheatsheets/1
  # GET /cheatsheets/1.json
  def show
    @cheatsheet = Cheatsheet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cheatsheet }
    end
  end

  # GET /cheatsheets/new
  # GET /cheatsheets/new.json
  def new
    @cheatsheet = Cheatsheet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cheatsheet }
    end
  end

  # GET /cheatsheets/1/edit
  def edit
    @cheatsheet = Cheatsheet.find(params[:id])
  end

  # POST /cheatsheets
  # POST /cheatsheets.json
  def create
    @cheatsheet = Cheatsheet.new(params[:cheatsheet])

    respond_to do |format|
      if @cheatsheet.save
        format.html { redirect_to @cheatsheet, notice: 'Cheatsheet was successfully created.' }
        format.json { render json: @cheatsheet, status: :created, location: @cheatsheet }
      else
        format.html { render action: "new" }
        format.json { render json: @cheatsheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cheatsheets/1
  # PUT /cheatsheets/1.json
  def update
    @cheatsheet = Cheatsheet.find(params[:id])

    respond_to do |format|
      if @cheatsheet.update_attributes(params[:cheatsheet])
        format.html { redirect_to @cheatsheet, notice: 'Cheatsheet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cheatsheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cheatsheets/1
  # DELETE /cheatsheets/1.json
  def destroy
    @cheatsheet = Cheatsheet.find(params[:id])
    @cheatsheet.destroy

    respond_to do |format|
      format.html { redirect_to cheatsheets_url }
      format.json { head :no_content }
    end
  end
end
