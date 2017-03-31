require 'rails_helper'

feature 'User can delete his own answer', %q{
  In order to delete answer
  As a registered user
  I want to be able to delete it from the question page
} do
  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user: user)}
  given!(:answer) { create(:answer, user: user, question: question) }

  scenario 'Registered user deletes his own answer' do

    sign_in(user)

    visit question_path(question)

    expect(page).to have_content answer.content

    within ".answer" do
      click_on 'Delete'
    end
    expect(page).to have_content 'Your answer successfully deleted.'
    expect(page).to_not have_content answer.content
    expect(current_path).to eq question_path(question)
  end

  scenario 'Another user tries to delete question' do

    sign_in(user2)

    visit question_path(question)
    within ".answer" do
      expect(page).to_not have_link 'Delete'
    end

  end

  scenario 'Visitor tries to delete question' do

    visit question_path(question)
    expect(page).to_not have_link 'Delete'
  end

end