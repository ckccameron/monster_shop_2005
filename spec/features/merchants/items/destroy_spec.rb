require 'rails_helper'
RSpec.describe "A merchant can delete one of their items" do
  before(:each) do
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @ross = User.create!(name: 'Ross Geller', address: '33 Banana St', city: 'New York', state: 'NY', zip: '12345', email: 'dinosaurs_are_cool@turing.io', password: 'test124', role: 1)
    @merchant_user = MerchantUser.create!(merchant: @meg, user: @ross)

    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

    @regular_user = User.create(name: 'Neeru Ericsson', address: '33 Cherry St', city: 'Denver', state: 'CO', zip: '12346', email: 'neeru_is_cool@turing.io', password: 'test123', role: 0)

    @order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user: @regular_user, status: "pending")

    @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)

    visit '/login'

    fill_in :email, with: @ross.email
    fill_in :password, with: @ross.password
    click_on "Submit Information"

  end
  it "I can delete an item that has never been ordered" do
    visit '/merchant/items'

    within "#item-#{@chain.id}" do
      expect(page).to have_content("Delete Item")
      click_on "Delete Item"
    end

    expect(current_path).to eq("/merchant/items")

    expect(page).to have_content("#{@chain.name} has now been deleted")

    expect(page).to_not have_content("Price: $#{@chain.price}")
    expect(page).to_not have_css("img[src*='#{@chain.image}']")
    expect(page).to_not have_content(@chain.description)
    expect(page).to_not have_content("Inventory: #{@chain.inventory}")
  end

  it "I can't delete an item that has orders" do
    visit '/merchant/items'

    within "#item-#{@tire.id}" do
      expect(page).to_not have_content("Delete Item")
    end
  end
end
