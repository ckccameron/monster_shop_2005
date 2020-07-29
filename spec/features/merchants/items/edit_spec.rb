require 'rails_helper'

RSpec.describe "As a merchant employee" do
  it "When I visit my items page and I click the edit button or link next to any item. Then I am taken to a form similar to the 'new item' form" do
    meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    ross = User.create!(name: 'Ross Geller', address: '33 Banana St', city: 'New York', state: 'NY', zip: '12345', email: 'dinosaurs_are_cool@turing.io', password: 'test124', role: 1)
    merchant_user = MerchantUser.create!(merchant: meg, user: ross)
    tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    visit '/login'

    fill_in :email, with: ross.email
    fill_in :password, with: ross.password
    click_on "Submit Information"

    visit '/merchant/items'

    within ".items-#{tire.id}" do
      expect(page).to have_content("Edit Item")
      click_on "Edit Item"
    end

    expect(current_path).to eq("/merchant/items/#{tire.id}/edit")

    expect(find_field('Name').value).to eq "Gatorskins"
    expect(find_field('Price').value).to eq "100"
    expect(find_field('Description').value).to eq "They'll never pop!"
    expect(find_field('Image').value).to eq("https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588")
    expect(find_field('Inventory').value).to eq '12'

    fill_in 'Name', with: "GatorSkins"
    fill_in 'Price', with: 110
    fill_in 'Description', with: "They're a bit more expensive, and they kinda do pop sometimes, but whatevs.. this is retail."
    fill_in 'Image', with: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588"
    fill_in 'Inventory', with: 130
    click_button "Update Item"

    expect(current_path).to eq('/merchant/items')

    expect(page).to have_content("Item Updated")

    expect(page).to have_content("GatorSkins")
    expect(page).to_not have_content("Gatorskins")
    expect(page).to have_content( "110")
    expect(page).to have_content("130")
    expect(page).to_not have_content("12")
    expect(page).to_not have_content("100")
    expect(page).to have_content("They're a bit more expensive, and they kinda do pop sometimes, but whatevs.. this is retail.")
    expect(page).to_not have_content("They'll never pop!")
  end

  it "when I try to edit an exisiting item and the data is missing" do
    meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    ross = User.create!(name: 'Ross Geller', address: '33 Banana St', city: 'New York', state: 'NY', zip: '12345', email: 'dinosaurs_are_cool@turing.io', password: 'test124', role: 1)
    merchant_user = MerchantUser.create!(merchant: meg, user: ross)
    tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    visit '/login'

    fill_in :email, with: ross.email
    fill_in :password, with: ross.password
    click_on "Submit Information"

    visit '/merchant/items'

    within ".items-#{tire.id}" do
      expect(page).to have_content("Edit Item")
      click_on "Edit Item"
    end

    expect(current_path).to eq("/merchant/items/#{tire.id}/edit")

    expect(find_field('Name').value).to eq "Gatorskins"
    expect(find_field('Price').value).to eq "100"
    expect(find_field('Description').value).to eq "They'll never pop!"
    expect(find_field('Image').value).to eq("https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588")
    expect(find_field('Inventory').value).to eq '12'

    fill_in 'Name', with: "GatorSkins"
    fill_in 'Price', with: -1237134735087214659
    fill_in 'Description', with: "They're a bit more expensive, and they kinda do pop sometimes, but whatevs.. this is retail."
    fill_in 'Image', with: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588"
    fill_in 'Inventory', with: 130
    click_button "Update Item"

    expect(current_path).to eq("/merchant/items/#{tire.id}/edit")

    expect(page).to have_content("Price must be greater than 0")

    expect(find_field('Name').value).to eq "Gatorskins"
    expect(find_field('Description').value).to eq "They'll never pop!"
    expect(find_field('Image').value).to eq("https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588")
    expect(find_field('Inventory').value).to eq '12'
  end
end
