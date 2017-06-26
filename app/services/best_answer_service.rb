class BestAnswerService

  def initialize(answer)
    @answer = answer
    @question = @answer.question
  end

  def set_answer_as_best
    if @question.has_best_answer?
      @question.best_answer.update_attribute(:best, false)
    end
    @answer.update_attribute(:best, true)
  end

end