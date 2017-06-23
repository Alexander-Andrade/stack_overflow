require_relative 'acceptance_helper'

feature 'Question editing', %q{
  In order to fix mistake in question
  As an author of question
  I'd like to be able edit my question
}do

  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:another_user_question) { create(:question, user: another_user) }

  describe 'Authenticated user' do
    before do
      sign_in user
    end

    scenario 'Author tries to edit his question', js: true do
      visit question_path(question)

      within "#question-#{question.id}" do
        expect(page).to have_content question.title
        expect(page).to have_content question.body

        within '.question-actions' do
          expect(page).to have_link 'Edit'
          click_on 'Edit'
        end
        expect(page).to have_selector 'textarea'
        within '.edit_question' do
          fill_in 'Title', with: 'Title 123'
          fill_in 'Body', with: 'Body 123'
          click_on 'Update'
        end

        expect(page).to_not have_content question.title
        expect(page).to_not have_content question.body
        expect(page).to_not have_selector 'textarea'
        expect(page).to have_content 'Title 123'
        expect(page).to have_content 'Body 123'
      end
    end

    scenario "tries to edit another user's question" , js: true do
      visit question_path(another_user_question)

      within "#question-#{another_user_question.id}" do
        expect(page).to have_content another_user_question.title
        expect(page).to have_content another_user_question.body
        expect(page).to_not have_link 'Edit'
      end
    end

  end

  describe 'Unauthenticated user' do

    before do
      visit question_path(question)
    end

    scenario "tries to edit someone's question" , js: true do
      within "#question-#{question.id}" do
        expect(page).to have_content question.title
        expect(page).to have_content question.body
        expect(page).to_not have_link 'Edit'
      end
    end

  end
end