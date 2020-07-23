require 'rails_helper'

RSpec.describe "Logging in to your account" do
  before(:each) do
    @regular_user = User.create(name: 'Neeru Ericsson', address: '33 Cherry St', city: 'Denver', state: 'CO', zip: '12346', email: 'neeru_is_cool@turing.io', password: 'test123', role: 0)
    @merchant_user = User.create(name: 'Ross Geller', address: '33 Banana St', city: 'New York', state: 'NY', zip: '12345', email: 'dinosaurs_are_cool@turing.io', password: 'test124', role: 1)
    @admin_user = User.create(name: 'Napoleon Bonaparte', address: '33 Shorty Ave', city: 'Los Angeles', state: 'CA', zip: '12345', email: 'french_people_rule@turing.io', password: 'test125', role: 2)
  end

  it "When a regular user visits the login path they can enter information in to login and are directed to profile page" do
    visit '/login'

    fill_in :email, with: @regular_user.email
    fill_in :password, with: @regular_user.password
    click_on "Submit Information"

    expect(current_path).to eq("/profile")
    expect(page).to have_content(("Logged in as #{@regular_user.name}"))
  end

  it "When a merchant user visits the login path they can enter information in to login and are directed to merchant dashboard" do
    visit '/login'

    fill_in :email, with: @merchant_user.email
    fill_in :password, with: @merchant_user.password
    click_on "Submit Information"

    expect(current_path).to eq("/merchant")
    expect(page).to have_content("Logged in as #{@merchant_user.name}")
  end

  it "When an admin user visits the login path they can enter information in to login and are directed to admin dashboard" do
    visit '/login'

    fill_in :email, with: @admin_user.email
    fill_in :password, with: @admin_user.password
    click_on "Submit Information"
    expect(current_path).to eq("/admin")
    expect(page).to have_content("Logged in as #{@admin_user.name}")
  end

  it "user cannot log in with bad credentials" do
    visit "/login"

    fill_in :email, with: @admin_user.email
    fill_in :password, with: "thisisthewrongpassword"
    click_on "Submit Information"

    expect(current_path).to eq("/login")
    expect(page).to have_content("Sorry, your credentials are invalid")
  end

  it "can see the same links as a visitor plus profile, logout, but not login" do
    user_1 = User.create(name: 'Neeru Ericsson', address: '33 Cherry St', city: 'Denvor', state: 'CA', zip: '12346', email: 'neeru_is_cool@turing.io', password: 'test123')

    visit '/login'

    fill_in :email, with: @regular_user.email
    fill_in :password, with: @regular_user.password
    click_on "Submit Information"

    expect(current_path).to eq("/profile")
    expect(page).to have_content("Logged in as #{@regular_user.name}")
    expect(page).to have_content('Profile')
    expect(page).to have_content('Logout')
    expect(page).to_not have_content('Login')
  end
end
