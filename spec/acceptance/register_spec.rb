require 'rails_helper'

feature 'Visitor can register', %q{
  In order to be able to ask questions
  As an Visitor
  I want to be able to register
} do

  scenario 'Visitor tries to register' do
    visit new_user_registration_path
    fill_in 'Email', with: Faker::Internet.email
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'

    expect(page).to have_content "Welcome! You have signed up successfully."
    expect(current_path).to eq root_path

  end
end