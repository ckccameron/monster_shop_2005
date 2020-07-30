require 'rails_helper'
RSpec.describe "Admin users show page" do
  before(:each) do
    @admin_user = User.create(name: 'Napoleon Bonaparte', address: '33 Shorty Ave', city: 'Los Angeles', state: 'CA', zip: '12345', email: 'french_people_rule@turing.io', password: 'test125', role: 2)
    @regular_user = User.create(name: 'Neeru Ericsson', address: '33 Cherry St', city: 'Denver', state: 'CO', zip: '12346', email: 'neeru_is_cool@turing.io', password: 'test123')
    @merchant_user = User.create(name: 'Ross Geller', address: '33 Banana St', city: 'New York', state: 'NY', zip: '12345', email: 'dinosaurs_are_cool@turing.io', password: 'test124', role: 1)
    @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
    MerchantUser.create(merchant: @bike_shop, user: @merchant_user)

    visit '/login'
    fill_in :email, with: @admin_user.email
    fill_in :password, with: @admin_user.password
    click_on "Submit Information"
  end

  it "I see the same information a user would see themselves except a link to edit profile" do
    visit "/admin/users"

    within ".user_id-#{@regular_user.id}" do
      click_on "#{@regular_user.name}"
    end

    expect(current_path).to eq("/admin/users/#{@regular_user.id}")
    expect(page).to have_content(@regular_user.name)
    expect(page).to have_content(@regular_user.address)
    expect(page).to have_content(@regular_user.city)
    expect(page).to have_content(@regular_user.state)
    expect(page).to have_content(@regular_user.zip)
    expect(page).to have_content(@regular_user.email)
    expect(page).to_not have_content("Edit Profile")

    visit "/admin/users/#{@merchant_user.id}"
    expect(page).to have_link("View All Merchant Items")
    expect(page).to have_content("All Pending Orders:")
  end

end
