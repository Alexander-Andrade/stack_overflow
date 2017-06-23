require_relative 'acceptance_helper'

feature 'Browse question list', %q{
  In order to browse question list
  As an visitor (not user)
  A want to get to question list page without authentication
} do
  given(:user) { create(:user) }
  given!(:questions) { create_list(:question, 3, user: user) }

  scenario 'Visitor browses question list' do
    visit questions_path
    questions.each do |q|
      expect(page).to have_content q.title
    end
  end



end