class Category < ActiveRecord::Base
	has_many :transactions
	validates_presence_of :user_id
	def self.user_categories(user_id)
		Category.where(user_id: user_id)
	end
end
