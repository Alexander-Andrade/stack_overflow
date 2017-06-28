class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: [:create]
  before_action :find_answer, only: [:update, :set_best, :destroy]

  def create
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def update
    if current_user.author_of? @answer
      @answer.update_attributes(answer_params)
      @question = @answer.question
    end
  end

  def set_best
    @question = @answer.question
    if current_user.author_of? @question
      @answer.set_as_best
      @answers = @question.answers.all
    end
  end

  def destroy
    if current_user.author_of? @answer
      @answer.destroy!
      flash[:notice] = 'Your answer successfully deleted.'
    else
      flash[:error] = 'Your could not delete another answer.'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:content, attachments_attributes: [:file])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end

end
