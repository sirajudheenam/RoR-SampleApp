class Answer < ApplicationRecord
	include HasGravatar

	belongs_to :question

	# moved to HasGravatar Module
	# def gravatar
	# "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}"
	# end
end
