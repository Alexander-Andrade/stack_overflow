require 'rails_helper'

RSpec.describe Answer, type: :model do
  context 'assotiations' do
    it { should belong_to(:question) }
    it { should belong_to(:user) }
  end

  context 'validations' do
    it { should validate_presence_of :content }
  end

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }
  let(:another_answer) { create(:answer, question: question, user: user) }

  context 'method best?' do
    it 'returns true if the answer is best' do
      answer.set_as_best
      expect(answer).to be_best
    end

    it 'has the best answer, after it is set' do
      another_answer.set_as_best
      expect(answer).to_not be_best
    end
  end

  context 'method set_as_best' do
    before do
      answer.set_as_best
    end
    it 'sets answer as the best' do
      expect(answer).to be_best
    end

    it 'another answer is not the best' do
      expect(another_answer).to_not be_best
    end

  end

end
