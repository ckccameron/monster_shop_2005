require 'rails_helper'
RSpec.describe "Delete a merchant's item" do
before(:each) do
  @admin_user = User.create(name: 'Napoleon Bonaparte', address: '33 Shorty Ave', city: 'Los Angeles', state: 'CA', zip: '12345', email: 'french_people_rule@turing.io', password: 'test125', role: 2)
  @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
  @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
  @shifter = @meg.items.create(name: "Shimano Shifters", description: "It'll always shift!", price: 180, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 2)

  @regular_user = User.create(name: 'Neeru Ericsson', address: '33 Cherry St', city: 'Denver', state: 'CO', zip: '12346', email: 'neeru_is_cool@turing.io', password: 'test123', role: 0)

  @order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user: @regular_user, status: "pending")

  @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)

  visit '/login'
  fill_in :email, with: @admin_user.email
  fill_in :password, with: @admin_user.password
  click_on "Submit Information"
end






User Story 45, Merchant adds an item

As a merchant employee
When I visit my items page
I see a link to add a new item
When I click on the link to add a new item
I see a form where I can add new information about an item, including:
- the name of the item, which cannot be blank
- a description for the item, which cannot be blank
- a thumbnail image URL string, which CAN be left blank
- a price which must be greater than $0.00
- my current inventory count of this item which is 0 or greater

When I submit valid information and submit the form
I am taken back to my items page
I see a flash message indicating my new item is saved
I see the new item on the page, and it is enabled and available for sale
If I left the image field blank, I see a placeholder image for the thumbnail
