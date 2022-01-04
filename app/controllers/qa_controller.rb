class QaController < ApplicationController
  # def current_user_email
  #   session[:current_user_email] || 'No email is saved.'
  # end

  def index
  	logger.warn "*** BEGIN RAW REQUEST HEADERS ***"
  	self.request.env.each do |header|
  		logger.warn "HEADER KEY: #{header[0]}"
  		logger.warn "HEADER VAL: #{header[1]}"
  	end
  	logger.warn "*** END RAW REQUEST HEADERS ***"

  	@questions = Question.order(created_at: :desc).all
  end

  def about
  end

end
