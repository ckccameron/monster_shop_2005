require 'rails_helper'

RSpec.describe 'As a registered user, merchant, or admin' do
  before :each do
    @user = User.create(name: "Dobby", address: '23 Hogwarts Ave', city: 'Glasgow', state: 'Scotland', zip: '23456', email: 'elvz_rule@owl.io', password: "h@rrypotterisindanger!", role: 0)
    @merchant = User.create(name: "Honeydukes", address: '123 Hogsmeade Ln.', city: 'Hogsmeade', state: 'Scotland', zip: '80203', email: '2sweet@owl.io', password: "everyeeeflavour!", role: 1)
    @admin = User.create(name: "Dumbledore", address: '100 Hogwarts Ave', city: 'Glasgow', state: 'Scotland', zip: '23456', email: 'headmaster@owl.io', password: "beardsRkewl168", role: 2)

  end
  describe "When I visit the logout path" do
    it "I am redirected to the welcome / home page of the site" do
      bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      visit "/login"

      fill_in :email, with: @admin.email
      fill_in :password, with: @admin.password
      click_on "Submit Information"
      cart = Cart.new(tire)

      visit '/logout'

      expect(current_path).to eq("/")
      expect(page).to have_content("You have logged out")

      within ".topnav" do
        expect(page).to have_content("Cart: 0")
      end
    end
  end
end
