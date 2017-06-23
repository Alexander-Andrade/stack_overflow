require_relative 'acceptance_helper'

feature 'Answer editing', %q{
  In order to fix mistake
  As an author of answer
  I'd like to be able edit my answer
}do

  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user:user)}
  given!(:another_user_answer) { create(:answer, question: question, user:another_user)}


  describe 'Authenticated user' do
    before do
      sign_in user
      visit question_path(question)
    end

    scenario 'Author tries to edit his answer', js: true do
      within "#answer-#{answer.id}" do
        expect(page).to have_content answer.content

        within '.answer-actions' do
          expect(page).to have_link 'Edit'
          click_on 'Edit'
        end
        expect(page).to have_selector 'textarea'
        within '.edit_answer' do
          fill_in 'Text', with: 'Answer 1234'
          click_on 'Update'
        end

        expect(page).to_not have_content answer.content
        expect(page).to_not have_selector 'textarea'
        expect(page).to have_content 'Answer 1234'
      end
    end

    scenario "tries to edit another user's answer" , js: true do
      within "#answer-#{another_user_answer.id}" do
        expect(page).to have_content another_user_answer.content
        expect(page).to_not have_link 'Edit'
      end
    end

  end

  describe 'Unauthenticated user' do

    before do
      visit question_path(question)
    end

    scenario "tries to edit someone's answer" , js: true do
      within ".answers" do
        expect(page).to_not have_link 'Edit'
      end
    end

  end
end