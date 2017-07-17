class Answer < ApplicationRecord
  default_scope { order(best: :desc, created_at: :asc) }

  belongs_to :user
  belongs_to :question
  has_many :attachments, as: :attachable, inverse_of: :attachable, dependent: :destroy

  accepts_nested_attributes_for :attachments, reject_if: :all_blank

  validates :content, presence: true

  def set_as_best
    Answer.transaction do
      if question.has_best_answer?
        question.best_answer.update!(best: false)
      end
      update!(best: true)
    end
  end
end
