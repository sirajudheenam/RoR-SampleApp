class QuestionsController < ApplicationController
	def show 
		@question = Question.find(params[:id])
		# preparing the view ordered by when it is created.
		@answers = @question.answers.order(created_at: :desc)	
	end
	def create
		# Question.create(params[:question])
		Question.create(question_params)

		session[:current_user_email] = question_params[:email]
		
		redirect_to root_path
	end

	private
		def question_params
			params.require(:question).permit(:email, :body)
		end
end
