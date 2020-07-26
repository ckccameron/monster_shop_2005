require 'rails_helper'
RSpec.describe "User views an order show page" do
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

  it "When I visit my profile orders page I see a link for the order's show page" do
    visit '/profile/orders'

    within ".orders-#{@new_order.id}" do
      click_on "View More Order Details"
    end

    expect(current_path).to eq("/profile/orders/#{@new_order.id}")
  end

  it "On the profile orders show page I see information about the order" do
    visit "/profile/orders/#{@new_order.id}"

    expect(page).to have_content(@new_order.id)
    expect(page).to have_content(@new_order.created_at)
    expect(page).to have_content(@new_order.updated_at)
    expect(page).to have_content(@new_order.status)
    expect(page).to have_content(@new_order.total_items)
    expect(page).to have_content(@new_order.grandtotal)

    within "#item-#{@pencil.id}" do
      expect(page).to have_content(@pencil.name)
      expect(page).to have_content(@pencil.description)
      expect(page).to have_css("img[src*='#{@pencil.image}']")
      expect(page).to have_content(@pencil.price)
      expect(page).to have_content("$2.00")
      expect(page).to have_content("1")
    end

    within "#item-#{@tire.id}" do
      expect(page).to have_content(@tire.name)
      expect(page).to have_content(@tire.description)
      expect(page).to have_css("img[src*='#{@tire.image}']")
      expect(page).to have_content(@tire.price)
      expect(page).to have_content("$100.00")
      expect(page).to have_content("1")
    end
  end

  it "I see a link to cancel the order" do
    visit "/profile/orders/#{@new_order.id}"
    click_on "Cancel Order"
    expect(current_path).to eq("/profile")

    expect(page).to have_content("Order #{@new_order.id} has now been cancelled")
    
    visit "/profile/orders/#{@new_order.id}"

    within ".order-status" do
      expect(page).to have_content("cancelled")
    end

    within "#item-name-#{@pencil.id}" do
      expect(page).to have_content("UNFULFILLED")
    end

    within "#item-description-#{@pencil.id}" do
      expect(page).to have_content("UNFULFILLED")
    end

    within "#item-price-#{@pencil.id}" do
      expect(page).to have_content("UNFULFILLED")
    end

    within "#item-qty-#{@pencil.id}" do
      expect(page).to have_content("UNFULFILLED")
    end

    within "#item-subtotal-#{@pencil.id}" do
      expect(page).to have_content("UNFULFILLED")
    end

    within "#total-item-qty" do
      expect(page).to have_content("0")
    end
  end
end
