class Report < ActiveRecord::Base
has_many :categories, :primary_key => 'user_id', :foreign_key => 'user_id' 
  def after_initialize
    self.edate ||= Date.today if new_record?
  end

  def self.date_range(transactions)
    if transactions.count > 0
       transactions.sort_by! {|obj| obj.tran_date}
       {:first_date => transactions.first.tran_date, :last_date => transactions.last.tran_date}
     else
      {first_date: DateTime.now - 30, last_date: DateTime.now}
     end
  end

  def self.filter_transactions(report,trans)
    if report
      report.attributes.each do |key, val|
      	if !val.blank? 
          if Report.columns_hash[key].type == :string
            trans = trans.where("#{key} like ?","%#{val}%")
          else
            trans = trans.where(key => val) unless Report.columns_hash[key].type == :date
          end    
      	end
      end
    end
      trans =trans.where("tran_date >= ?", report.sdate).where("tran_date <= ?", report.edate).order('tran_date DESC')
  end

  def self.report_instance(transaction_params=nil)
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

  def self.totals(report)


  end

  def self.category_sums(transaction_params,trans,report)

    user = User.find(report.user_id)
    cats = user.categories
    summary = {}
    total = 0.0
    sub_total = 0.0

    if transaction_params
      cats.each do |cat|
        if report.user_id
sub_total = trans.where(:category_id => cat.id, :user_id => report.user_id ).where("tran_date >= ?", report.sdate).where("tran_date <= ?", report.edate).order('tran_date DESC').sum(:amount)
  
        else
	sub_total = trans.where(:category_id => cat.id).where("tran_date >= ?", report.sdate).where("tran_date <= ?", report.edate).order('tran_date DESC').sum(:amount)
	
  end
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
