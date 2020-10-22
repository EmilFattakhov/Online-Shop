# Preview all emails at http://localhost:3000/rails/mailers/answer_mailer
class AnswerMailerPreview < ActionMailer::Preview
  def new_answer
    answer=Answer.first
    AnswerMailer.new_answer(answer)
  end
end
