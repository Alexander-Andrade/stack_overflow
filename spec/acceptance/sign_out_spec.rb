require 'rails_helper'

feature 'User sign out', %q{
  In order to sign in as another user
  As an User
  I want to be able to sign out
} do

  given(:user) { create(:user) }

  scenario 'Registered user try to sign out' do

    sign_in(user)
    click_on 'Log Out'
    expect(page).to have_content 'Signed out successfully.'
    expect(page).to have_content 'Log In'
  end

  scenario 'Non-registered user try to sign out' do
    visit root_path
    expect(page).to have_content 'Log In'
    expect(page).to have_content 'Sign Up'
    expect(page).to have_no_content 'Log Out'
  end

end