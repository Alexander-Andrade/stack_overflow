require 'rails_helper'

RSpec.describe User, type: :model do

  context 'assotiations' do
    it { should have_many(:questions).dependent(:destroy) }
    it { should have_many(:answers).through(:questions) }
  end

  context 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end

  context 'method author_of?' do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let(:own_question) { create(:question, user: user) }
    let(:another_question) { create(:question, user: another_user) }
    let(:own_answer) { create(:answer, question: own_question, user: user) }
    let(:another_answer) { create(:answer, question: another_question, user: another_user) }

    it 'returns true if question belongs to user' do
      expect(user).to be_author_of(own_question)
    end

    it 'returns true if answer belongs to user' do
      expect(user).to be_author_of(own_answer)
    end

    it 'returns false if question belongs to another user' do
      expect(user).to_not be_author_of(another_question)
    end

    it 'returns false if answer belongs to another user' do
      expect(user).to_not be_author_of(another_answer)
    end

  end
end