class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: [:new, :create]

  # def new
  #   @answer = @question.answers.new
  # end

  def create
    @answer = @question.answers.build(answer_params)
    debugger
    if @answer.save
      flash[:notice] = 'Your answer successfully created.'
      redirect_to @question
    else
      render 'questions/show'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

end
