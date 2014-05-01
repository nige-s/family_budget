class BankTransfersController < ApplicationController
  before_action :set_bank_transfer, only: [:show, :edit, :update, :destroy]

  # GET /bank_transfers
  # GET /bank_transfers.json
  def index
    @bank_transfers = BankTransfer.all
  end

  # GET /bank_transfers/1
  # GET /bank_transfers/1.json
  def show
  end

  # GET /bank_transfers/new
  def new
    @bank_transfer = BankTransfer.new
  end

  # GET /bank_transfers/1/edit
  def edit
  end

  # POST /bank_transfers
  # POST /bank_transfers.json
  def create
    @bank_transfer = BankTransfer.new(bank_transfer_params)
    BankTransfer.process_transfer(@bank_transfer)
    
    respond_to do |format|
      if @bank_transfer.save
        format.html { redirect_to @bank_transfer, notice: 'Bank transfer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bank_transfer }
      else
        format.html { render action: 'new' }
        format.json { render json: @bank_transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bank_transfers/1
  # PATCH/PUT /bank_transfers/1.json
  def update
    respond_to do |format|
      if @bank_transfer.update(bank_transfer_params)
        format.html { redirect_to @bank_transfer, notice: 'Bank transfer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bank_transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bank_transfers/1
  # DELETE /bank_transfers/1.json
  def destroy
    @bank_transfer.destroy
    respond_to do |format|
      format.html { redirect_to bank_transfers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank_transfer
      @bank_transfer = BankTransfer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bank_transfer_params
      params.require(:bank_transfer).permit(:src_account_id, :target_account_id, :tran_date, :amount, :description, :src_user_id, :target_user_id)
    end
end
