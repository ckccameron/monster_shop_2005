require 'rails_helper'

RSpec.describe 'new user page', type: :feature do
  it 'can register a new user' do

    visit '/'

    within ".topnav" do
      expect(page).to have_link('Register')
      click_on "Register"
    end

    expect(current_path).to eq('/register')

    password = "test"

    within '.registration_form' do
      expect(page).to have_content('Name')
      expect(page).to have_content('Address')
      expect(page).to have_content('City')
      expect(page).to have_content('State')
      expect(page).to have_content('Zip')
      expect(page).to have_content('Email')
      expect(page).to have_content('Password')
      expect(page).to have_content('Confirm password')

      fill_in 'Name', with: 'Neeru Eric'
      fill_in 'Address', with: '33 Chery St'
      fill_in 'City', with: 'Denver'
      fill_in 'State', with: 'CO'
      fill_in 'Zip', with: '12345'
      fill_in 'Email', with: 'neeru_is_cool@turing.io'
      fill_in 'Password', with: password
      fill_in 'Confirm password', with: password
      click_on 'Create User'
    end

    expect(current_path).to eq('/profile')

    expect(page).to have_content('You are now registered and logged in')
  end
end
