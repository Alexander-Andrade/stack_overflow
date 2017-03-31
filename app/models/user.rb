class User < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :answers, through: :questions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def author_of?(item)
    item.user_id == id
  end
end
