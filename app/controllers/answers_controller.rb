class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: [:new, :create]
  before_action :find_answer, only: [:destroy]

  def create
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    @answer.save!
  end

  def destroy
    if current_user.author_of? @answer
      @answer.destroy!
      flash[:notice] = 'Your answer successfully deleted.'
    else
      flash[:error] = 'Your could not delete another answer.'
    end
    redirect_to @answer.question
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end

end
