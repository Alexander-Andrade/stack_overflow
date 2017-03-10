require 'rails_helper'

RSpec.describe Answer, type: :model do
  context 'assotiations' do
    it { should belong_to(:question) }
  end

  context 'validations' do
    it { should validate_presence_of :content }
  end
end
