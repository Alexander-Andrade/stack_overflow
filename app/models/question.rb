class Question < ApplicationRecord
  has_many :answers, dependent: :destroy

  validates :title, presence: true, length: { in: 6..255 }, uniqueness: { case_sensitive: false }
  validates :body,  presence: true
end
