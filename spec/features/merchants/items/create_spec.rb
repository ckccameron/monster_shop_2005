require 'rails_helper'
RSpec.describe "A merchant can delete one of their items" do
  before(:each) do
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @ross = User.create!(name: 'Ross Geller', address: '33 Banana St', city: 'New York', state: 'NY', zip: '12345', email: 'dinosaurs_are_cool@turing.io', password: 'test124', role: 1)
    @merchant_user = MerchantUser.create!(merchant: @meg, user: @ross)

    @name = "Chain"
    @description = "It'll never break!"
    @price = 50
    @image = "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588"
    @inventory = 5

    visit '/login'

    fill_in :email, with: @ross.email
    fill_in :password, with: @ross.password
    click_on "Submit Information"
  end

  it "I can add a new item" do
    visit '/merchant/items'

    expect(page).to have_link("Add Item")

    click_on "Add Item"

    expect(current_path).to eq('/merchant/items/new')

    fill_in :name, with: @name
    fill_in :price, with: @price
    fill_in :description, with: @description
    fill_in :inventory, with: @inventory

    click_button "Create Item"

    @new_item = Item.last

    expect(current_path).to eq('/merchant/items')

    expect(page).to have_content("#{@new_item.name} has been created")

    within "#item-#{@new_item.id}" do

      expect(page).to have_link(@new_item.name)
      expect(page).to have_content(@new_item.description)
      expect(page).to have_content("Price: $#{@new_item.price}")
      expect(page).to have_content("Active")
      expect(page).to have_content("Inventory: #{@new_item.inventory}")
      expect(page).to have_css("img[src*='#{@new_item.image}']")
    end
  end
end
