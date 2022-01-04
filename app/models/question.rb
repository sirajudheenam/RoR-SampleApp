class Question < ApplicationRecord
	
	include HasGravatar
	has_many :answers

end
