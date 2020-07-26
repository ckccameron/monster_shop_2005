require 'rails_helper'

RSpec.describe 'merchant dashboard show page', type: :feature do
  describe 'As a merchant employee' do
    before :each do
      @merchant_user = User.create(name: 'Ross Geller', address: '33 Banana St', city: 'New York', state: 'NY', zip: '12345', email: 'dinosaurs_are_cool@turing.io', password: 'test124', role: 1)
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      MerchantUser.create(merchant: @bike_shop, user: @merchant_user)
       # @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    #   @paper = @bike_shop.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
    #   @pencil = @bike_shop.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
    #   # @order_1 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
    #   # @order_2 = Order.create(name: 'Bob', address: '456 Main St', city: 'Hershee', state: 'MA', zip: 00034)
    #   # @item_order_1 = @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
    #   # @item_order_2 = @order_2.item_orders.create!(item: @paper, price: @paper.price, quantity: 10)
    end

    describe 'When I visit my merchant dashboard ("/merchant")' do
      it 'I see the name and full address of the merchant I work for' do
        visit '/login'

        fill_in :email, with: @merchant_user.email
        fill_in :password, with: @merchant_user.password
        click_on "Submit Information"

        expect(current_path).to eq("/merchant")

        expect(page).to have_content("Brian's Bike Shop")
        expect(page).to have_content("123 Bike Rd.\nRichmond, VA 23137")
      end
      # describe 'If any users have pending orders containing items I sell' do
      #   it 'I see a list of these orders' do
      #     visit "/merchants/#{@bike_shop.id}"
      #
      #     expect(page).to have_content

        # end
      # end
    end
#     Each order listed includes the following information:
# - the ID of the order, which is a link to the order show
# page ("/merchant/orders/15")
# - the date the order was made
# - the total quantity of my items in the order
# - the total value of my items for that order
  end
end
