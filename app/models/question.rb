class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable

  accepts_nested_attributes_for :attachments

  validates :title, presence: true, length: { in: 6..255 }, uniqueness: { case_sensitive: false }
  validates :body,  presence: true

  def has_best_answer?
    answers.exists? best:true
  end

  def best_answer
    answers.find_by best:true
  end
end
