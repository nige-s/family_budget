class ReconcileTransactionsController < ApplicationController
  before_action :set_reconcile_transaction, only: [:show, :edit, :update, :destroy]
  def index
    acc_id = params['account_id'] || 1
    @transactions = current_user.transactions.where(account_id: acc_id).where(reconciled: false).where("tran_date <= ?", Date.today).order('tran_date DESC')
  end

  def update

      respond_to do |format|
        if @reconcile_transaction.update(transaction_params)
          format.html { redirect_to reconcile_transaction, notice: 'Reconcile transaction was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: reconcile_transaction.errors, status: :unprocessable_entity }
        end
      end
  end

  def bulk_update
    if params[:save]
    transaction_params['transactions'].each do |tran|
      tran_for_update = Transaction.update(tran[1]['id'],reconciled: tran[1]['reconciled'])
    end
    elsif params[:update_bank]
      redirect_to action: 'index', account_id: params['account']['id']
    end
  end

  def create
    @reconcile_transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @reconcile_transaction.save
        format.html { redirect_to @reconcile_transaction, notice: 'Reconcile transaction was successfully created.' }
        format.json { render action: 'show', status: :created, location: @reconcile_transaction }
      else
        format.html { render action: 'new' }
        format.json { render json: @reconcile_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_reconcile_transaction
    @reconcile_transaction = Transaction.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def transaction_params

    params #.require(:transactions).permit(:user_id, :tran_date, :account_id, :category_id, :description, :supplier, :amount,:sign,:reconciled)
  end
end
