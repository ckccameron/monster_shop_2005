require 'rails_helper'

RSpec.describe 'merchant items index page', type: :feature do
  describe 'As a merchant employee' do
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
      @bike_pump = (name: "Hand Pump", description: "it's the pumpiest!", price: 12, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      @order_1 = Order.create!(name: 'Cam-Eric Ramessye', address: '33 Pineapple St', city: 'New York', state: 'NY', zip: '12345', user: @cam)
      @order_2 = Order.create!(name: 'Cam-Eric Ramessye', address: '33 Pineapple St', city: 'New York', state: 'NY', zip: '12345', user: @cam)
      @order_3 = Order.create!(name: 'Jim', address: '33 Pineapple St', city: 'New York', state: 'NY', zip: '12345', user: @jim)
      @order_4 = Order.create!(name: 'Jim Ramessye', address: '33 Pineapple St', city: 'New York', state: 'NY', zip: '12345', user: @jim)
      @item_order_1 = @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @item_order_2 = @order_1.item_orders.create!(item: @paper, price: @paper.price, quantity: 10)
      @item_order_3 = @order_3.item_orders.create!(item: @octopus, price: @octopus.price, quantity: 2)
      @item_order_3 = @order_4.item_orders.create!(item: @octopus, price: @octopus.price, quantity: 1)
    end

    describe "When I try to add a new item If any of my data is incorrect or missing (except image)" do
      it "Then I am returned to the form, I see one or more flash messages indicating each error I caused, and All fields are re-populated with my previous data" do

        visit '/login'

        fill_in :email, with: @ross.email
        fill_in :password, with: @ross.password
        click_on "Submit Information"

        visit "/merchant/items"

        expect(page).to have_link("Add Item")

        click_on "Add Item"

        expect(current_path).to eq("/merchant/items/new")

        fill_in :name, with: @bike_pump.name
        fill_in :price, with: @bike_pump.price
        fill_in :description, with: @bike_pump.description
        fill_in :inventory, with: @bike_pump.inventory

        click_on "Create Item"

        expect(current_path).to eq("/merchant/items")

        within "#item-#{@bike_pump.id}" do
          expect(page).to have_link(@bike_pump.name)
          expect(page).to have_content(@bike_pump.description)
          expect(page).to have_content("Price: $#{@bike_pump.price}")
          expect(page).to have_content("Active")
          expect(page).to have_content("Inventory: #{@bike_pump.inventory}")
          expect(page).to have_css("img[src*='#{@bike_pump.image}']")
        end

        expect(page).to have_content("New Item Saved!")
      end
    end
  end
end
