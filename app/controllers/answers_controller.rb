class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: [:new, :create]
  before_action :find_answer, only: [:destroy]

  def create
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    if @answer.save
      flash[:notice] = 'Your answer successfully created.'
      redirect_to @question
    else
      flash[:notice] = 'The answer is invalid.'
      redirect_to @question
    end
  end

  def destroy
    @question = @answer.question
    @answer.destroy!
    flash[:notice] = 'Your answer successfully deleted.'
    redirect_to @question
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
