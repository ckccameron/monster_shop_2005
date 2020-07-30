require 'rails_helper'

RSpec.describe "admin dashboard index page" do
  before :each do
    @regular_user = User.create(name: 'Neeru Ericsson', address: '33 Cherry St', city: 'Denver', state: 'CO', zip: '12346', email: 'neeru_is_cool@turing.io', password: 'test123', role: 0)
    @admin_user = User.create(name: 'Napoleon Bonaparte', address: '33 Shorty Ave', city: 'Los Angeles', state: 'CA', zip: '12345', email: 'french_people_rule@turing.io', password: 'test125', role: 2)

    # @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

    @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    @catnip = @brian.items.create(name: "Catnip", description: "It'll get your cat super high", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 50)
    @scratch_pad = @brian.items.create(name: "Scratch Pad", description: "Pretty scratchy", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 5)
    @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

    @order_1 = @regular_user.orders.create!(name: "Neeru Ericsson", address: "33 Cherry St", city: "Denver", state: "CO", zip: "12346", status: 2)
    @order_1.item_orders.create(order: @order_1, item: @pull_toy, price: @pull_toy.price, quantity: 2)

    @order_2 = @regular_user.orders.create!(name: "Neeru Ericsson", address: "33 Cherry St", city: "Denver", state: "CO", zip: "12346", status: 0)
    @order_2.item_orders.create(order: @order_2, item: @catnip, price: @catnip.price, quantity: 2)

    @order_3 = @regular_user.orders.create!(name: "Neeru Ericsson", address: "33 Cherry St", city: "Denver", state: "CO", zip: "12346", status: 3)
    @order_3.item_orders.create(order: @order_3, item: @scratch_pad, price: @scratch_pad.price, quantity: 2)

    @order_4 = @regular_user.orders.create!(name: "Neeru Ericsson", address: "33 Cherry St", city: "Denver", state: "CO", zip: "12346", status: 1)
    @order_4.item_orders.create(order: @order_4, item: @dog_bone, price: @dog_bone.price, quantity: 2)

    @order_5 = @regular_user.orders.create!(name: "Neeru Ericsson", address: "33 Cherry St", city: "Denver", state: "CO", zip: "12346", status: 0)
    @order_5.item_orders.create(order: @order_5, item: @dog_bone, price: @dog_bone.price, quantity: 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
  end

  it "shows user who placed order, order id and date the order was created" do
    visit "/admin/"
    expect(page).to have_content("Admin Dashboard")

    within ".shipped-orders" do
      expect(page).to have_link(@order_1.name)
      expect(page).to have_content(@order_1.id)
      expect(page).to have_content(@order_1.created_at.to_date)
      expect(page).to have_content(@order_1.status)
    end
  end

  it "sorts orders by status" do
    visit "/admin/"
    expect(page).to have_content("Admin Dashboard")

    within ".packaged-orders" do
      expect(page).to have_link(@order_2.name)
      expect(page).to have_content(@order_2.id)
      expect(page).to have_content(@order_2.created_at.to_date)
      expect(page).to have_link(@order_5.name)
      expect(page).to have_content(@order_5.id)
      expect(page).to have_content(@order_5.created_at.to_date)
    end

    within ".pending-orders" do
      expect(page).to have_link(@order_4.name)
      expect(page).to have_content(@order_4.id)
      expect(page).to have_content(@order_4.created_at.to_date)
    end

    within ".shipped-orders" do
      expect(page).to have_link(@order_1.name)
      expect(page).to have_content(@order_1.id)
      expect(page).to have_content(@order_1.created_at.to_date)
    end

    within ".cancelled-orders" do
      expect(page).to have_link(@order_3.name)
      expect(page).to have_content(@order_3.id)
      expect(page).to have_content(@order_3.created_at.to_date)
    end
  end

  it "allows admin to ship orders" do
    visit "/admin/"

    within ".packaged-orders" do
      expect(page).to_not have_content("shipped")
      expect(page).to have_link("Ship Order")
    end

    within "#order-ship-#{@order_2.id}" do
      click_on "Ship Order"
    end

    expect(page).to have_content("shipped")

    within ".packaged-orders" do
      expect(page).to_not have_content(@order_2.id)
    end

    within ".shipped-orders" do
      expect(page).to have_content(@order_2.id)
    end
  end
end
