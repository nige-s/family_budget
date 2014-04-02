class Transaction < ActiveRecord::Base
	belongs_to :trantype
	belongs_to :user
	belongs_to :category

	paginates_per 20
end
