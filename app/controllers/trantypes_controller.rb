class TrantypesController < ApplicationController
  before_action :set_trantype, only: [:show, :edit, :update, :destroy]

  # GET /trantypes
  # GET /trantypes.json
  def index
    @trantypes = Trantype.all
  end

  # GET /trantypes/1
  # GET /trantypes/1.json
  def show
  end

  # GET /trantypes/new
  def new
    @trantype = Trantype.new
  end

  # GET /trantypes/1/edit
  def edit
  end

  # POST /trantypes
  # POST /trantypes.json
  def create
    @trantype = Trantype.new(trantype_params)

    respond_to do |format|
      if @trantype.save
        format.html { redirect_to @trantype, notice: 'Trantype was successfully created.' }
        format.json { render action: 'show', status: :created, location: @trantype }
      else
        format.html { render action: 'new' }
        format.json { render json: @trantype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trantypes/1
  # PATCH/PUT /trantypes/1.json
  def update
    respond_to do |format|
      if @trantype.update(trantype_params)
        format.html { redirect_to @trantype, notice: 'Trantype was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @trantype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trantypes/1
  # DELETE /trantypes/1.json
  def destroy
    @trantype.destroy
    respond_to do |format|
      format.html { redirect_to trantypes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trantype
      @trantype = Trantype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trantype_params
      params.require(:trantype).permit(:name, :desc)
    end
end
