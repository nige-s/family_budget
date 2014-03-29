class ReportsController < ApplicationController

	def index

		if params['report']
			filter
		else
			@trans = Transaction.all
			@report = Report.new
			@report.sdate = "01/01/2013"
		end

	end

	def filter
		if params['report']
			@report = Report.new(transaction_params)
			@trans = Transaction.all
			 @report.sdate = Date.today - 30 if @report.sdate == nil
			 @report.edate = Date.today if @report.edate == nil
			if @report.user
				@trans = @trans.where(:user_id => @report.user)
			end

			if @report.trantype
				@trans = @trans.where(:trantype_id => @report.trantype)
			end

			if @report.category
				@trans = @trans.where(:category_id => @report.category)
			end
				
			@trans = @trans.where("tran_date >= ?", @report.sdate).where("tran_date <= ?", @report.edate).order('tran_date DESC')
		else
			@trans = Transaction.all
			@report = Report.new
			@report.sdate = "01/01/2013"
		end
		@total = @trans.sum(:amount)
	end

	def summary
		@cats = Category.all
		@summary = {}

		@cats.each do |cat|
			@summary[cat.name] = Transaction.where(:category_id => cat.id).sum(:amount)
		end
	end
	# Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:report).permit(:user, :sdate, :edate, :trantype, :category, :range)
    end
end
