class AnswersController < ApplicationController
	def create
		question = Question.find(params[:answer][:question_id])
	    # Answer.create(answer_params)
	    # instead of the above
	    answer = question.answers.create(answer_params)
		MainMailer.notify_question_author(answer).deliver_now

	    session[:current_user_email] = answer_params[:email]

	    #redirect question_path
	    # or simply
	    redirect_to question
	end
	private

	def answer_params
		params.require(:answer).permit(:question_id, :email, :body)
	end
end
