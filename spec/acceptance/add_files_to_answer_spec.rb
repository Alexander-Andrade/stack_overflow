require_relative 'acceptance_helper'

feature 'Add files to answer', %q{
  In order to illustrate my answer,
  As an answer's author
  I'd like to be able to attach files
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  background do
    sign_in user
    visit question_path(question)
  end

  scenario 'User adds file when asks a question',js: true do
    within '.new-answer' do
      fill_in 'Text', with: 'Test Answer'
      attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
      click_on 'Create'
    end
    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end

end