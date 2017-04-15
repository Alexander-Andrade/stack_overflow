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

    it 'returns true if arg belongs to user' do
      expect(user.author_of?(own_question)).to eq true
      expect(user.author_of?(own_answer)).to eq true
    end

    it 'returns false if arg belongs to another user' do
      expect(user.author_of?(another_question)).to eq false
      expect(user.author_of?(another_answer)).to eq false
    end
  end
end