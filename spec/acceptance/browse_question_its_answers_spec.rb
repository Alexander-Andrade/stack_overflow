require_relative 'acceptance_helper'

feature 'Browse question and its answer', %q{
  In order to browse question and its answers
  As an visitor (not user)
  A want to navigate to the question page
} do
  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answers) { create_list(:answer, 3, question: question, user:user) }

  scenario 'Visitor browses question and its answers' do
    visit question_path(question)
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    answers.each do |a|
      expect(page).to have_content a.content
    end
  end



end