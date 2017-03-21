class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :user_id, presence: true
  validates :title, presence: true, length: { in: 6..255 }, uniqueness: { case_sensitive: false }
  validates :body,  presence: true
end
