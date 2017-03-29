require 'rails_helper'

RSpec.describe Question, type: :model do
  context 'assotiations' do
    it { should have_many(:answers).dependent(:destroy) }
    it { should belong_to(:user) }
  end

  context 'validations' do
    it { should validate_presence_of :title }
    it { should validate_length_of(:title).is_at_least(6).is_at_most(255) }
    it { should validate_uniqueness_of(:title).case_insensitive }
    it { should validate_presence_of :body }
  end
end
