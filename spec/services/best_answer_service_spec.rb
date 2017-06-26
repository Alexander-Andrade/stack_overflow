require 'rails_helper'

RSpec.describe BestAnswerService do

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }
  let(:another_answer) { create(:answer, question: question, user: user) }
  subject { BestAnswerService.new(answer) }

  context 'method set_answer_as_best' do

    it 'sets answer as the best' do
      subject.set_answer_as_best
      expect(answer).to be_best
    end

    it 'another answer is not the best' do
      subject.set_answer_as_best
      expect(another_answer).to_not be_best
    end

  end
end