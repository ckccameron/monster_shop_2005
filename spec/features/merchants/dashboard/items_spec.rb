require 'rails_helper'

RSpec.describe 'merchant items page', type: :feature do
  describe 'As a merchant employee, when I visit my items page' do
    before :each do
      @ross = User.create!(name: 'Ross Geller', address: '33 Banana St', city: 'New York', state: 'NY', zip: '12345', email: 'dinosaurs_are_cool@turing.io', password: 'test124', role: 1)
      @cam = User.create!(name: 'Cam-Eric Ramessye', address: '33 Pineapple St', city: 'New York', state: 'NY', zip: '12345', email: 'dinosaurs_are_dope@turing.io', password: 'test124', role: 0)
      @jim = User.create!(name: 'Jim Ramessye', address: '33 Pineapple St', city: 'New York', state: 'NY', zip: '12345', email: 'lemurs_are_dope@turing.io', password: 'test124', role: 0)
      @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      @little_shop = Merchant.create!(name: "Small Shoppe", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      @merchant_user = MerchantUser.create!(merchant: @bike_shop, user: @ross)
      @tire = @bike_shop.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @octopus = @little_shop.items.create!(name: "Octopus", description: "Inky!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @paper = @bike_shop.items.create!(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @pencil = @bike_shop.items.create!(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      @order_1 = Order.create!(name: 'Cam-Eric Ramessye', address: '33 Pineapple St', city: 'New York', state: 'NY', zip: '12345', user: @cam)
      @order_2 = Order.create!(name: 'Cam-Eric Ramessye', address: '33 Pineapple St', city: 'New York', state: 'NY', zip: '12345', user: @cam)
      @order_3 = Order.create!(name: 'Jim', address: '33 Pineapple St', city: 'New York', state: 'NY', zip: '12345', user: @jim)
      @order_4 = Order.create!(name: 'Jim Ramessye', address: '33 Pineapple St', city: 'New York', state: 'NY', zip: '12345', user: @jim)
      @item_order_1 = @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @item_order_2 = @order_1.item_orders.create!(item: @paper, price: @paper.price, quantity: 10)
      @item_order_3 = @order_3.item_orders.create!(item: @octopus, price: @octopus.price, quantity: 2)
      @item_order_3 = @order_4.item_orders.create!(item: @octopus, price: @octopus.price, quantity: 1)

      visit '/login'

      fill_in :email, with: @ross.email
      fill_in :password, with: @ross.password
      click_on "Submit Information"
    end
    it 'I see all of my items: name, description, price, image, status, inventory' do
      visit '/merchant/items'

      expect(page).to have_content(@pencil.name)
      expect(page).to have_content(@pencil.description)
      expect(page).to have_content(@pencil.price)
      expect(page).to have_content(@pencil.image)
      expect(page).to have_content("Status: Active")
      expect(page).to have_content(@pencil.inventory)
    end
    it 'I see a link or button to deactivate the item next to each item that is active' do
      visit '/merchant/items'

      expect(page).to have_link("Deactivate")

      within ".items-#{@pencil.id}" do
        click_on "Deactivate"
      end
    end
  end
end
# User Story 42, Merchant deactivates an item
#
# As a merchant employee
# When I visit my items page
# I see all of my items with the following info:
#  - name
# - description
# - price
# - image
# - active/inactive status
# - inventory
# I see a link or button to deactivate the item next
#  to each item that is active
# And I click on the "deactivate" button or link
#  for an item
# I am returned to my items page
# I see a flash message indicating this item
#  is no longer for sale
# I see the item is now inactive
