class ReportsController < ApplicationController
  before_action :user_transactions, only: [:index, :transactions_filter, :summary]

  def index
    

    @report = Report.report_instance(transaction_params)


    @transactions = Report.filter_transactions(@report,@trans,@cats,@trantypes)
    @tran_count = @transactions.count
    @date_range = Report.date_range(@transactions)
    @total = @transactions.sum(:amount)
    
    #required for pagination
    @transactions = @transactions.page params[:page]
  end

  def summary
    @report = Report.report_instance(transaction_params)
    @summary = Report.category_sums(transaction_params)
    @total = @trans.sum(:amount)
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def transaction_params
  	if params[:report]
      params.require(:report).permit(:user_id, :sdate, :edate, :range, :sign, :category_id => [], :trantype_id => []) 
	else
	  nil
	end
  end

  private
  def user_transactions
    @trans = Transaction.user_transactions(current_user)
  end
end
