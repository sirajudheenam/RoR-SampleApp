class MainMailer < ApplicationMailer
  
  def notify_question_author(answer)
    @greeting = "Hi"
    @answer = answer

    mail to: answer.question.email, from: answer.email
  end
end
