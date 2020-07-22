require 'rails_helper'

RSpec.describe "Logging in to your account" do
  before(:each) do
    @regular_user = User.create(name: 'Neeru Ericsson', address: '33 Cherry St', city: 'Denver', state: 'CO', zip: '12346', email: 'neeru_is_cool@turing.io', password: 'test123', role: 1)
    @merchant_user = User.create(name: 'Ross Geller', address: '33 Banana St', city: 'New York', state: 'NY', zip: '12345', email: 'dinosaurs_are_cool@turing.io', password: 'test124', role: 2)
    @admin_user = User.create(name: 'Napoleon Bonaparte', address: '33 Shorty Ave', city: 'Los Angeles', state: 'CA', zip: '12345', email: 'french_people_rule@turing.io', password: 'test125', role: 3)

  end
  it "When a regular user visits the login path they can enter information in to login and are directed to profile page" do
    visit '/login'

    fill_in :email, with: @regular_user.email
    fill_in :password, with: @regular_user.password
    click_on "Submit Information"
    expect(current_path).to eq("/profile")
  end

  # it "When a merchant user visits the login path they can enter information in to login and are directed to merchant dashboard" do
  #   visit '/login'
  #
  #   fill_in email:, :with @merchant_user.email
  #   fill_in password:, :with @merchant_user.password
  #   click_on "Submit Information"
  #   expect(current_path).to eq("/merchant")
  # end
  #
  # it "When an admin user visits the login path they can enter information in to login and are directed to admin dashboard" do
  #   visit '/login'
  #
  #   fill_in email:, :with @admin_user.email
  #   fill_in password:, :with @admin_user.password
  #   click_on "Submit Information"
  #   expect(current_path).to eq("/merchant")
  # end
end


# User Story 13, User can Login
#
# As a visitor
# When I visit the login path
# I see a field to enter my email address and password
# When I submit valid information
# If I am a regular user, I am redirected to my profile page --> /profile
# If I am a merchant user, I am redirected to my merchant dashboard page --> /merchant
# If I am an admin user, I am redirected to my admin dashboard page --> /admin
# And I see a flash message that I am logged in
