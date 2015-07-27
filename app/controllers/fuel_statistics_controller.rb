class FuelStatisticsController < ApplicationController
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
    @transactions = Transaction.user_transactions(current_user).where('description LIKE ?', '%px04ytm')
    @count = @transactions.count
    @total = Transaction.sum_transactions(@transactions) 
    @transactions = @transactions.page params[:page]
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    @transaction.user_id = current_user.id
    last = Transaction.where(category_id: 2).where('description LIKE ?','fuel [%').where('description LIKE ?', '%px04ytm')
    if last.any?
      mileage = last.first.description.split(' ')
      mileage = mileage[2].gsub(']', '')
      @last_mileage = mileage.to_i
    end
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new#Transaction.new(transaction_params)
    prepare_record_for_save(@transaction)
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
    params.require(:transaction).permit(:user_id, :tran_date, :account_id, :category_id, :description, :supplier, :amount,:sign,:mileage)
  end

  def prepare_record_for_save(transaction)
    transaction.tran_date = transaction_params[:tran_date]
    transaction.category_id = 2
    transaction.account_id = transaction_params[:account_id]
    transaction.amount = transaction_params[:amount]
    transaction.supplier = transaction_params[:supplier] || 'NA'
    transaction.user_id = transaction_params[:user_id]
    transaction.sign = transaction_params[:sign]
    transaction.tran_date = Date.new transaction_params["tran_date(1i)"].to_i, transaction_params["tran_date(2i)"].to_i, transaction_params["tran_date(3i)"].to_i
    mpg = params[:mpg].to_d.round(0).to_i
    transaction.description = "fuel [#{params[:price_litre]} #{transaction_params[:mileage]}] mpg:#{mpg} #{params[:reg_number]}"
    transaction
  end
end
