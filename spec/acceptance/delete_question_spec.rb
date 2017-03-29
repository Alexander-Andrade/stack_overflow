require 'rails_helper'

feature 'User can delete his own question', %q{
  In order to delete question
  As a registered user
  I want to be able to delete it from the question page
} do
  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given(:question) { create(:question, user: user)}

  scenario 'Registered user deletes his own question' do

    sign_in(user)

    visit question_path(question)
    click_on 'Delete'
    expect(page).to have_content 'Your question successfully deleted.'
    expect(current_path).to eq questions_path
  end

  scenario 'Another user tries to delete question' do

    sign_in(user2)

    visit question_path(question)
    expect(page).to_not have_link 'Delete'
  end

  scenario 'Visitor tries to delete question' do

    visit question_path(question)
    expect(page).to_not have_link 'Delete'
  end

end