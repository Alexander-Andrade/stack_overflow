require 'rails_helper'

RSpec.describe Question, type: :model do
  context 'assotiations' do
    it { should have_many(:answers).dependent(:destroy) }
    it { should belong_to(:user) }
    it { should have_many(:attachments)}
    it { should accept_nested_attributes_for :attachments}
  end

  context 'validations' do
    it { should validate_presence_of :title }
    it { should validate_length_of(:title).is_at_least(6).is_at_most(255) }
    it { should validate_uniqueness_of(:title).case_insensitive }
    it { should validate_presence_of :body }
  end

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }

  context 'method has_best_answer?' do

    it 'has not the best answer initially' do
      expect(question.has_best_answer?).to eq false
    end

    it 'has the best answer, after it is set' do
      answer.set_as_best
      expect(question.has_best_answer?).to eq true
    end
  end

  context 'method best_answer' do
    it 'returns answer with true best field ' do
      answer.set_as_best
      expect(question.best_answer).to eq answer
    end
  end
end
