class ReportsController < ApplicationController
  before_action :user_transactions, only: [:index, :transactions_filter, :summary]

  def index
    if params[:first_button]
      @report = Report.report_instance(transaction_params)
    elsif params[:second_button]
      @report = Report.report_instance
    end
    
    @report ||= Report.report_instance(transaction_params)
    if params['report']
        @trans = Report.filter_transactions(@report,@trans)
    end

    if @trans
      @tran_count = @trans.count
    else
      @trans = 0
    end

    @date_range = Report.date_range(@trans)
    @period = @date_range[:last_date] - @date_range[:first_date]
    @total = @trans.sum(:amount)
    
    #required for pagination
    @trans = @trans.page params[:page]
  end

  def reset
    @report = Report.report_instance
    redirect_to action: 'index'
  end

  def summary
    @report = Report.report_instance(transaction_params)
    @summary = Report.category_sums(transaction_params,@trans,@report)
    @total = @trans.sum(:amount)
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def transaction_params
  	if params[:report]
      params.require(:report).permit(:user_id, :sdate, :edate, :range, :sign, :description, :supplier, :amount, :category_id => [], :trantype_id => []) 
	else
	  nil
	end
  end

  private
  def user_transactions
    @trans = Transaction.user_transactions(current_user)
  end
end
