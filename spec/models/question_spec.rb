require 'rails_helper'

RSpec.describe Question, type: :model do
  context 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
    it { should validate_length_of :title }
    it { should validate_uniqueness_of(:title).case_insensitive }
  end
  context 'assotiations' do
    it { should have_many :answers }
  end
end
