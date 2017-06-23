class Answer < ApplicationRecord
  default_scope { order(best: :desc, created_at: :asc) }

  belongs_to :user
  belongs_to :question

  validates :content, presence: true

  def best?
    best
  end
end
