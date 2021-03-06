class TransactionsController < ApplicationController
  layout "application"
  skip_before_action :authenticate_user!
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  before_action :check_auth

  def authourise
    # @authourised = Account.owns_account?(current_user.id,params[:id])
  end
  def check_auth
    redirect_to :welcome => :index unless user_signed_in?   
  end  
  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.user_transactions(current_user)
    @count = @transactions.count
    @total = Transaction.sum_transactions(@transactions) 
    @transactions = @transactions.page params[:page]
  end
  def edit_deposit
    @transaction = Transaction.find(params[:id])
  end
  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  def deposit
    @transaction = Transaction.new(user_id: current_user.id)
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    @transaction.user_id = current_user.id
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render action: 'show', status: :created, location: @transaction }
      else
        format.html { render action: 'new' }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    begin
      @transaction = current_user.transactions.find(params[:id])
    rescue
      flash[:error] = "Not authourised to view the transaction you attempted to access"
      redirect_to transactions_path
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def transaction_params
    params.require(:transaction).permit(:user_id, :tran_date, :account_id, :category_id, :description, :supplier, :amount,:sign)
  end
end
