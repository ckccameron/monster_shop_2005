require 'rails_helper'
RSpec.describe "Users index page" do
  before(:each) do
    @admin_user = User.create(name: 'Napoleon Bonaparte', address: '33 Shorty Ave', city: 'Los Angeles', state: 'CA', zip: '12345', email: 'french_people_rule@turing.io', password: 'test125', role: 2)
    @regular_user = User.create(name: 'Neeru Ericsson', address: '33 Cherry St', city: 'Denver', state: 'CO', zip: '12346', email: 'neeru_is_cool@turing.io', password: 'test123')
    @merchant_user = User.create(name: 'Ross Geller', address: '33 Banana St', city: 'New York', state: 'NY', zip: '12345', email: 'dinosaurs_are_cool@turing.io', password: 'test124', role: 1)
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @shifter = @meg.items.create(name: "Shimano Shifters", description: "It'll always shift!", price: 180, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 2)

    visit '/login'
    fill_in :email, with: @admin_user.email
    fill_in :password, with: @admin_user.password
    click_on "Submit Information"
  end

  it "When I click the 'Users' link in the nav I see all users in the system" do
    visit '/'
    click_on "All Users"
    expect(current_path).to eq("/admin/users")

      within ".user_id-#{@regular_user.id}" do
        expect(page).to have_link(@regular_user.name)
        expect(page).to have_content(@regular_user.created_at)
        expect(page).to have_content(@regular_user.role)
      end

      within ".user_id-#{@merchant_user.id}" do
        expect(page).to have_link(@merchant_user.name)
        expect(page).to have_content(@merchant_user.created_at)
        expect(page).to have_content(@merchant_user.role)
      end
    end
  end
