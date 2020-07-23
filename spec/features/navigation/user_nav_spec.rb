require 'rails_helper'

RSpec.describe "user navigation bar" do
  before(:each) do
    @user = User.create(name: 'Neeru Ericsson', address: '33 Cherry St', city: 'Denver', state: 'CO', zip: '12346', email: 'neeru_is_cool@turing.io', password: 'test123', role: 0)
  end
  it "can see the same links as a visitor plus profile, logout, but not login" do
    visit '/login'

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    click_on "Submit Information"

    expect(current_path).to eq("/profile")
    expect(page).to have_content("Logged in as #{@user.name}")
    expect(page).to have_content('Profile')
    expect(page).to have_content('Log Out')
    expect(page).to_not have_content('Login')
  end
end
