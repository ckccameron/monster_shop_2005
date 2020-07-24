require 'rails_helper'

RSpec.describe "As a registered user when I visit my profile page" do
  before(:each) do
    @regular_user = User.create(name: 'Neeru Ericsson', address: '33 Cherry St', city: 'Denver', state: 'CO', zip: '12346', email: 'neeru_is_cool@turing.io', password: 'test123', role: 0)
    @merchant_user = User.create(name: 'Ross Geller', address: '33 Banana St', city: 'New York', state: 'NY', zip: '12345', email: 'dinosaurs_are_cool@turing.io', password: 'test124', role: 1)
    @admin_user = User.create(name: 'Napoleon Bonaparte', address: '33 Shorty Ave', city: 'Los Angeles', state: 'CA', zip: '12345', email: 'french_people_rule@turing.io', password: 'test125', role: 2)
  end
  it "Then I see all of my profile data on the page except my password and I see a link to edit my profile data" do
    visit '/login'

    fill_in :email, with: @regular_user.email
    fill_in :password, with: @regular_user.password
    click_on "Submit Information"

    expect(current_path).to eq("/profile")
    expect(page).to have_content(@regular_user.name)
    expect(page).to have_content(@regular_user.address)
    expect(page).to have_content(@regular_user.city)
    expect(page).to have_content(@regular_user.state)
    expect(page).to have_content(@regular_user.zip)
    expect(page).to have_content(@regular_user.email)
    expect(page).to have_content("Edit Profile")
  end

  it "When I click the link to edit my profile data " do
    visit '/login'

    fill_in :email, with: @regular_user.email
    fill_in :password, with: @regular_user.password
    click_on "Submit Information"

    expect(current_path).to eq("/profile")

    click_on "Edit Profile"

    expect(current_path).to eq("/profile/edit")

    expect(find_field(:name).value).to eq(@regular_user.name)
    expect(find_field(:address).value).to eq(@regular_user.address)
    expect(find_field(:city).value).to eq(@regular_user.city)
    expect(find_field(:state).value).to eq(@regular_user.state)
    expect(find_field(:zip).value).to eq(@regular_user.zip)
    expect(find_field(:email).value).to eq(@regular_user.email)

    fill_in :state, with: "KY"

    click_button "Submit Data"

    expect(current_path).to eq("/profile")

    expect(page).to have_content("Profile updated successfully")

    expect(page).to have_content("KY")
    expect(page).to_not have_content("CO")
  end

  it "allows user to edit password" do
    visit '/login'

    fill_in :email, with: @regular_user.email
    fill_in :password, with: @regular_user.password
    click_on "Submit Information"

    expect(current_path).to eq("/profile")

    click_on "Edit Password"

    expect(current_path).to eq("/profile/password/edit")

    fill_in :password, with: "123test"
    fill_in :confirm_password, with: "123test"
    click_on "Submit New Password"

    expect(current_path).to eq("/profile")
    expect(page).to have_content("Password updated successfully")
  end

  it "does not update password if password and confirm_password fields are not matching" do
    visit '/login'

    fill_in :email, with: @regular_user.email
    fill_in :password, with: @regular_user.password
    click_on "Submit Information"

    expect(current_path).to eq("/profile")

    click_on "Edit Password"

    expect(current_path).to eq("/profile/password/edit")

    fill_in :password, with: "123test"
    fill_in :confirm_password, with: "123test123"
    click_on "Submit New Password"

    expect(current_path).to eq("/profile/password/edit")
    expect(page).to have_content("Password update failed - password and password confirmation must be matching")
  end

  it "does not update password if either or both of password and confirm_password fields are blank" do
    visit '/login'

    fill_in :email, with: @regular_user.email
    fill_in :password, with: @regular_user.password
    click_on "Submit Information"

    expect(current_path).to eq("/profile")

    click_on "Edit Password"

    expect(current_path).to eq("/profile/password/edit")

    fill_in :password, with: ""
    fill_in :confirm_password, with: ""
    click_on "Submit New Password"

    expect(current_path).to eq("/profile/password/edit")
    expect(page).to have_content("Password update failed - password and/or password confirmation cannot be blank")
  end
end
