require 'rails_helper'

RSpec.describe "As a registered user when I visit my profile/orders page" do
  before(:each) do
    @regular_user = User.create(name: 'Neeru Ericsson', address: '33 Cherry St', city: 'Denver', state: 'CO', zip: '12346', email: 'neeru_is_cool@turing.io', password: 'test123', role: 0)
    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
    @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
    visit "/items/#{@paper.id}"
    click_on "Add To Cart"
    visit "/items/#{@tire.id}"
    click_on "Add To Cart"
    visit "/items/#{@pencil.id}"
    click_on "Add To Cart"

    visit '/login'

    fill_in :email, with: @regular_user.email
    fill_in :password, with: @regular_user.password
    click_on "Submit Information"

    visit '/cart'
    click_on "Checkout"

    fill_in :name, with: @regular_user.name
    fill_in :address, with: @regular_user.address
    fill_in :city, with: @regular_user.city
    fill_in :state, with: @regular_user.state
    fill_in :zip, with: @regular_user.zip

    click_button "Create Order"
    @new_order = Order.last
  end

  it "I see every order I've ever made, which includes order details" do
    visit '/profile/orders'
    expect(page).to have_content(@new_order.id)
    expect(page).to have_content(@new_order.created_at)
    expect(page).to have_content(@new_order.updated_at)
    expect(page).to have_content(@new_order.status)
    expect(page).to have_content(@new_order.items.count)
    expect(page).to have_content(@new_order.grandtotal)
  end
end
