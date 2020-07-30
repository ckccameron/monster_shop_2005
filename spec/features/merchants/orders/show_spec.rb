require 'rails_helper'

RSpec.describe 'merchant dashboard show page', type: :feature do
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
      @order_1 = Order.create!(name: 'Cam-Eric Ramessye', address: '33 Pineapple St', city: 'New York', state: 'NY', zip: '12345', user: @cam)
      @order_2 = Order.create!(name: 'Cam-Eric Ramessye', address: '33 Pineapple St', city: 'New York', state: 'NY', zip: '12345', user: @cam)
      @order_3 = Order.create!(name: 'Jim', address: '33 Pineapple St', city: 'New York', state: 'NY', zip: '12345', user: @jim)
      @order_4 = Order.create!(name: 'Jim Ramessye', address: '33 Pineapple St', city: 'New York', state: 'NY', zip: '12345', user: @jim)
      @item_order_1 = @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @item_order_2 = @order_1.item_orders.create!(item: @paper, price: @paper.price, quantity: 10)
      @item_order_3 = @order_1.item_orders.create!(item: @octopus, price: @octopus.price, quantity: 2)
      @item_order_3 = @order_4.item_orders.create!(item: @octopus, price: @octopus.price, quantity: 1)

      visit '/login'

      fill_in :email, with: @ross.email
      fill_in :password, with: @ross.password
      click_on "Submit Information"
    end
    describe 'When I visit an order show page from my dashboard' do
      it 'I see the recipients name and address that was used to create this order' do
        visit "/merchant/orders/#{@order_1.id}"

        within ".order-info" do
          expect(page).to have_content(@order_1.name)
          expect(page).to have_content(@order_1.address)
          expect(page).to have_content(@order_1.city)
          expect(page).to have_content(@order_1.state)
          expect(page).to have_content(@order_1.zip)
        end
      end
      it 'I only see the items in the order that are being purchased from my merchant and not from another merchant' do
        visit "/merchant/orders/#{@order_1.id}"

        within ".order-items" do
          expect(page).to have_content(@tire.name)
          expect(page).to_not have_content(@octopus.name)
        end
      end
      it 'For each item, I see the 1. item name which is a link to the item show page, 2. item image, 3. price for item, 4. item order quantity' do
        visit "/merchant/orders/#{@order_1.id}"

        within ".order-items" do
          expect(page).to have_link(@tire.name)
          expect(page).to have_selector("img[src$='#{@tire.image}']")
          expect(page).to have_content(@item_order_1.price)
          expect(page).to have_content(@item_order_1.quantity)

          click_on "#{@tire.name}"
          expect(current_path).to eq("/items/#{@tire.id}")
        end
      end
    end
  end
end
