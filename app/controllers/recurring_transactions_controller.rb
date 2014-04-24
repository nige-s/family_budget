class RecurringTransactionsController < ApplicationController
  before_action :set_recurring_transaction, only: [:show, :edit, :update, :destroy]

  # GET /recurring_transactions
  # GET /recurring_transactions.json
  def index
    @recurring_transactions = RecurringTransaction.all
  end

  # GET /recurring_transactions/1
  # GET /recurring_transactions/1.json
  def show
  end

  # GET /recurring_transactions/new
  def new
    @recurring_transaction = RecurringTransaction.new
  end

  # GET /recurring_transactions/1/edit
  def edit
  end

  # POST /recurring_transactions
  # POST /recurring_transactions.json
  def create
    @recurring_transaction = RecurringTransaction.new(recurring_transaction_params)

    respond_to do |format|
      if @recurring_transaction.save
        format.html { redirect_to @recurring_transaction, notice: 'Recurring transaction was successfully created.' }
        format.json { render action: 'show', status: :created, location: @recurring_transaction }
      else
        format.html { render action: 'new' }
        format.json { render json: @recurring_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recurring_transactions/1
  # PATCH/PUT /recurring_transactions/1.json
  def update
    respond_to do |format|
      if @recurring_transaction.update(recurring_transaction_params)
        format.html { redirect_to @recurring_transaction, notice: 'Recurring transaction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @recurring_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recurring_transactions/1
  # DELETE /recurring_transactions/1.json
  def destroy
    @recurring_transaction.destroy
    respond_to do |format|
      format.html { redirect_to recurring_transactions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recurring_transaction
      @recurring_transaction = RecurringTransaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recurring_transaction_params
      params.require(:recurring_transaction).permit(:account_id, :interval, :description, :amount, :sign, :active, :start_date, :end_date, :last_updated, :day, :category_id)
    end
end
