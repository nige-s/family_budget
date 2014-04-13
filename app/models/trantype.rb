class Trantype < ActiveRecord::Base
	has_many :transactions
	validates_presence_of :user_id

	def self.user_trantypes(user_id)
		if(user_id == 1 || user_id == 2)
		  Trantype.where(user_id: [1, 2])
	    else
	  	  Trantype.where(user_id: user_id)
	  end
	end
end
