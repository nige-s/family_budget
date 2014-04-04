class Report < ActiveRecord::Base
 
  def after_initialize
    self.edate ||= Date.today if new_record?
  end
  def self.filter_transactions(rport,trans)
    if rport
      rport.attributes.each do |key, val|
	if val 
	  trans = trans.where(key => val) unless Report.columns_hash[key].type == :date
	end
      trans =trans.where("tran_date >= ?", rport.sdate).where("tran_date <= ?", rport.edate).order('tran_date DESC')
      end
    end
    return trans
  end

  def self.report_instance(transaction_params)
    if transaction_params
      report = Report.new(transaction_params)
      report.sdate = Date.today - 30 if report.sdate == nil
      report.edate = Date.today if report.edate == nil
    else
      report = Report.new
      report.sdate = "22/03/2014"
      report.edate = Date.today
    end
    return report
  end

  def self.category_sums(transaction_params,trans,report)

    cats = Category.all
    summary = {}
    total = 0

    if transaction_params
      cats.each do |cat|
	sub_total = trans.where(:category_id => cat.id).where("tran_date >= ?", report.sdate).where("tran_date <= ?", report.edate).order('tran_date DESC').sum(:amount)
	total += sub_total 
	summary[cat.name] = sub_total
      end
    else
      report = Report.new
      report.sdate = "22/03/2014"
      report.edate = Date.today
      cats.each do |cat|
	sub_total  = trans.where(:category_id => cat.id).sum(:amount) 
	total += sub_total 
	summary[cat.name] = sub_total 
      end
    end
    summary['total']= total
    return summary
  end
end 
