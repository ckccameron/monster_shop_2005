require 'rails_helper'
RSpec.describe "Merchants index page" do
  before(:each) do
    @admin_user = User.create(name: 'Napoleon Bonaparte', address: '33 Shorty Ave', city: 'Los Angeles', state: 'CA', zip: '12345', email: 'french_people_rule@turing.io', password: 'test125', role: 2)
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

    visit '/login'
    fill_in :email, with: @admin_user.email
    fill_in :password, with: @admin_user.password
    click_on "Submit Information"
  end

  it "I can disable a merchant account" do
    visit '/admin/merchants'

    within ".merchant-#{@meg.id}" do
      click_link "Disable"
    end

    expect(current_path).to eq('/admin/merchants')
    expect(page).to have_content("#{@meg.name} is now disabled")

    within ".merchant-#{@meg.id}" do
      expect(page).to_not have_content("Disable")
    end
  end
end
