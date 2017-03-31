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

end