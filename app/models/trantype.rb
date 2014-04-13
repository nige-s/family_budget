class Trantype < ActiveRecord::Base
	has_many :transactions
	validates_presence_of :user_id

	def self.user_trantypes(user_id)
		Trantype.where(user_id: user_id)
	end
end
