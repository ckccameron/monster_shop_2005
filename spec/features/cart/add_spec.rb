require 'rails_helper'

RSpec.describe 'Cart creation' do
  describe 'When I visit an items show page' do

    before(:each) do
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
    end

    it "I see a link to add this item to my cart" do
      visit "/items/#{@paper.id}"
      expect(page).to have_button("Add To Cart")
    end

    it "I can add this item to my cart" do
      visit "/items/#{@paper.id}"
      click_on "Add To Cart"

      expect(page).to have_content("#{@paper.name} was successfully added to your cart")
      expect(current_path).to eq("/items")

      within 'nav' do
        expect(page).to have_content("Cart: 1")
      end

      visit "/items/#{@pencil.id}"
      click_on "Add To Cart"

      within 'nav' do
        expect(page).to have_content("Cart: 2")
      end
    end
    it "I can increment the count of items I want to purchase" do
    # visit "/items/#{@paper.id}"
    # click_on "Add To Cart"

      visit "/items/#{@pencil.id}"
      click_on "Add To Cart"

      visit '/cart'

      # within ".cart-item-#{@pencil.id}" do
      click_button "+"
      click_button "+"
      click_button "+"
      expect(page).to have_content("4")

#       within ".cart-item-#{@paper.id}" do
#         click_on "-"
#         expect(page).to have_content("0")
#       end
#       Next to each item in my cart
# I see a button or link to increment the count of items I want to purchase
# I cannot increment the count beyond the item's inventory size
    end
  end
end
