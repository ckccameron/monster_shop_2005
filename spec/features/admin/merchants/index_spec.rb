require 'rails_helper'
RSpec.describe "Merchants index page" do
  before(:each) do
    @admin_user = User.create(name: 'Napoleon Bonaparte', address: '33 Shorty Ave', city: 'Los Angeles', state: 'CA', zip: '12345', email: 'french_people_rule@turing.io', password: 'test125', role: 2)
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @shifter = @meg.items.create(name: "Shimano Shifters", description: "It'll always shift!", price: 180, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 2)

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

  it "When I disable a merchant all of their items are deactivated" do
    visit '/admin/merchants'

    within ".merchant-#{@meg.id}" do
      click_link "Disable"
    end

    visit "/merchants/#{@meg.id}/items"

    within "#item-#{@tire.id}" do
      expect(page).to have_content(@tire.name)
      expect(page).to have_content("Inactive")
    end

    within "#item-#{@shifter.id}" do
      expect(page).to have_content(@shifter.name)
      expect(page).to have_content("Inactive")
    end
  end
end
