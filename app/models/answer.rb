class Answer < ApplicationRecord
  default_scope { order(best: :desc, created_at: :asc) }

  belongs_to :user
  belongs_to :question

  validates :content, presence: true

  def best?
    best
  end

  def set_as_best
    Answer.transaction do
      if question.has_best_answer?
        question.best_answer.update!(best: false)
      end
      update!(best: true)
    end
  end
end
