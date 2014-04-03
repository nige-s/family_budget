class ReportsController < ApplicationController
	require 'transactions_filter.rb'
	before_action :user_transactions, only: [:index, :transactions_filter, :summary]

	@@total = 0

  def self.total
    @@total
  end

  def index
    if params['report']
	  transactions_filter
	else
	  #@trans = Transaction.all
	  @report = Report.new
	  @report.sdate = "01/03/2014"
    end

  end

  def transactions_filter
  	if params['report']
  	  @report = Report.new(transaction_params)
      @report.sdate = Date.today - 30 if @report.sdate == nil
	  @report.edate = Date.today if @report.edate == nil

	  @report.attributes.each do |key, val|
	    if val 
		  @trans = @trans.where(key => val) unless Report.columns_hash[key].type == :date
		end
	  end

      @trans = @trans.where("tran_date >= ?", @report.sdate).where("tran_date <= ?", @report.edate).order('tran_date DESC')
	else

      #@trans = Transaction.all
	  @report = Report.new
	  @report.sdate = "01/01/2013"
	end
	  @@total = @trans.sum(:amount)
  end

  def summary
  	@cats = Category.all
	@summary = {}

	  if params['report']
	  	@report = Report.new(transaction_params)
		@cats.each do |cat|
		  @summary[cat.name] = @trans.where(:category_id => cat.id).where("tran_date >= ?", @report.sdate).where("tran_date <= ?", @report.edate).order('tran_date DESC').sum(:amount)
		end
	  else
	    @report = Report.new
		@cats.each do |cat|
		  @summary[cat.name] = @trans.where(:category_id => cat.id).sum(:amount)
		end
	  end
	  @@total = @trans.sum(:amount)
	end
	# Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:report).permit(:user_id, :sdate, :edate, :trantype_id, :category_id, :range, :sign)
    end

    private
    def user_transactions
      tran_filter = TransactionsFilter.new
      @trans = tran_filter.user_transactions(current_user).page params[:page]
    end
end
