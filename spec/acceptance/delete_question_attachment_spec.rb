require_relative 'acceptance_helper'

feature 'User can deletes files, attached to his question', %q{
  In order to delete attached file
  As a registered user
  I want to be able to delete it from the question page
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:attachment) { create(:attachment, attachable: question) }

  scenario 'authenticated user tries to delete attachment to his question', js: true do

    sign_in user
    visit question_path question

    within "#attachment-#{attachment.id}" do
      click_on 'Delete'
    end

    expect(page).to_not have_content attachment.file.url
  end


  scenario "not authenticated user tries to delete attachment to someone's answer", js: true do
    visit question_path question

    within "#attachment-#{attachment.id}" do
      expect(page).to_not have_link 'Delete'
    end
  end

end