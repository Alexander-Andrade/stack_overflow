require_relative 'acceptance_helper'

feature 'User,while viewing the question, can write a response to it', %q{
  In order to answer a question
  As an authenticated user
  A want to write answer to a question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario 'Authenticated user creates answer', js: true do
    sign_in(user)

    visit question_path(question)

    fill_in 'Text', with: 'Test Answer'
    click_on 'Create'
    expect(page).to have_content 'Test Answer'
  end

  scenario 'Authenticated user creates invalid answer', js: true do
    sign_in(user)

    visit question_path(question)

    fill_in 'Text', with: ''
    click_on 'Create'
    expect(page).to have_content "Content can't be blank"
  end

  scenario 'Visitor(not user) wants to create answer', js: true do
    visit question_path(question)
    fill_in 'Text', with: ''
    click_on 'Create'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end