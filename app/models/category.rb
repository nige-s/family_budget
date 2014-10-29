class Category < ActiveRecord::Base
	has_many :transactions
	belongs_to :user
	belongs_to :report, :primary_key => 'user_id'
	validates_presence_of :user_id
	def self.user_categories(user_id)
      if(user_id == 1 || user_id == 2)
		Category.where(user_id: [1, 2]).order(:name)
	  else
	  	Category.where(user_id: user_id).order(:name)
    end
	end
end
