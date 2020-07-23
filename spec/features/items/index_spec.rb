require 'rails_helper'

RSpec.describe "Items Index Page" do
  describe "When I visit the items index page" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @wheel = @meg.items.create(name: "A bike wheel", description: "A super awesome wheel", price: 150, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 25)
      @helmet = @meg.items.create(name: "Brain Cage", description: "A cage to protect your head", price: 150, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 70)

      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @catnip = @brian.items.create(name: "Catnip", description: "It'll get your cat super high", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 50)
      @scratch_pad = @brian.items.create(name: "Scratch Pad", description: "Pretty scratchy", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 5)
      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

      @rmerchant_user = User.create(name: 'Neeru Ericsson', address: '33 Cherry St', city: 'Denver', state: 'CO', zip: '12346', email: 'neeru_is_cool@turing.io', password: 'test123', role: 0)
      @admin_user = User.create(name: 'Ross Geller', address: '33 Banana St', city: 'New York', state: 'NY', zip: '12345', email: 'dinosaurs_are_cool@turing.io', password: 'test124', role: 1)
      @admin_user = User.create(name: 'Napoleon Bonaparte', address: '33 Shorty Ave', city: 'Los Angeles', state: 'CA', zip: '12345', email: 'french_people_rule@turing.io', password: 'test125', role: 2)
    end

    it "all items or merchant names are links" do
      visit '/items'

      expect(page).to have_link(@tire.name)
      expect(page).to have_link(@tire.merchant.name)
      expect(page).to have_link(@pull_toy.name)
      expect(page).to have_link(@pull_toy.merchant.name)
      expect(page).to_not have_link(@dog_bone.name)
      expect(page).to have_link(@dog_bone.merchant.name)
    end

    it "I can see a list of all of the items except disabled items "do

      visit '/items'

      within "#item-#{@tire.id}" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_content(@tire.description)
        expect(page).to have_content("Price: $#{@tire.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@tire.inventory}")
        expect(page).to have_link(@meg.name)
        expect(page).to have_css("img[src*='#{@tire.image}']")
      end

      within "#item-#{@pull_toy.id}" do
        expect(page).to have_link(@pull_toy.name)
        expect(page).to have_content(@pull_toy.description)
        expect(page).to have_content("Price: $#{@pull_toy.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@pull_toy.inventory}")
        expect(page).to have_link(@brian.name)
        expect(page).to have_css("img[src*='#{@pull_toy.image}']")
      end

        expect(page).to_not have_link(@dog_bone.name)
        expect(page).to_not have_content(@dog_bone.description)
        expect(page).to_not have_content("Price: $#{@dog_bone.price}")
        expect(page).to_not have_content("Inactive")
        expect(page).to_not have_content("Inventory: #{@dog_bone.inventory}")
        expect(page).to_not have_css("img[src*='#{@dog_bone.image}']")
    end

    it "A rmerchant user can visit the page and see all items except disabled items" do
      visit '/login'
      fill_in :email, with: @rmerchant_user.email
      fill_in :password, with: @rmerchant_user.password
      click_on "Submit Information"

      visit '/items'

      within "#item-#{@tire.id}" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_content(@tire.description)
        expect(page).to have_content("Price: $#{@tire.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@tire.inventory}")
        expect(page).to have_link(@meg.name)
        expect(page).to have_css("img[src*='#{@tire.image}']")
      end

      within "#item-#{@pull_toy.id}" do
        expect(page).to have_link(@pull_toy.name)
        expect(page).to have_content(@pull_toy.description)
        expect(page).to have_content("Price: $#{@pull_toy.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@pull_toy.inventory}")
        expect(page).to have_link(@brian.name)
        expect(page).to have_css("img[src*='#{@pull_toy.image}']")
      end

        expect(page).to_not have_link(@dog_bone.name)
        expect(page).to_not have_content(@dog_bone.description)
        expect(page).to_not have_content("Price: $#{@dog_bone.price}")
        expect(page).to_not have_content("Inactive")
        expect(page).to_not have_content("Inventory: #{@dog_bone.inventory}")
        expect(page).to_not have_css("img[src*='#{@dog_bone.image}']")
    end

    it "A merchant user can visit the page and see all items except disabled items" do
      visit '/login'
      fill_in :email, with: @admin_user.email
      fill_in :password, with: @admin_user.password
      click_on "Submit Information"

      visit '/items'

      within "#item-#{@tire.id}" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_content(@tire.description)
        expect(page).to have_content("Price: $#{@tire.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@tire.inventory}")
        expect(page).to have_link(@meg.name)
        expect(page).to have_css("img[src*='#{@tire.image}']")
      end

      within "#item-#{@pull_toy.id}" do
        expect(page).to have_link(@pull_toy.name)
        expect(page).to have_content(@pull_toy.description)
        expect(page).to have_content("Price: $#{@pull_toy.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@pull_toy.inventory}")
        expect(page).to have_link(@brian.name)
        expect(page).to have_css("img[src*='#{@pull_toy.image}']")
      end

        expect(page).to_not have_link(@dog_bone.name)
        expect(page).to_not have_content(@dog_bone.description)
        expect(page).to_not have_content("Price: $#{@dog_bone.price}")
        expect(page).to_not have_content("Inactive")
        expect(page).to_not have_content("Inventory: #{@dog_bone.inventory}")
        expect(page).to_not have_css("img[src*='#{@dog_bone.image}']")
    end

    it "A merchant user can visit the page and see all items except disabled items" do
      visit '/login'
      fill_in :email, with: @admin_user.email
      fill_in :password, with: @admin_user.password
      click_on "Submit Information"

      visit '/items'

      within "#item-#{@tire.id}" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_content(@tire.description)
        expect(page).to have_content("Price: $#{@tire.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@tire.inventory}")
        expect(page).to have_link(@meg.name)
        expect(page).to have_css("img[src*='#{@tire.image}']")
      end

      within "#item-#{@pull_toy.id}" do
        expect(page).to have_link(@pull_toy.name)
        expect(page).to have_content(@pull_toy.description)
        expect(page).to have_content("Price: $#{@pull_toy.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@pull_toy.inventory}")
        expect(page).to have_link(@brian.name)
        expect(page).to have_css("img[src*='#{@pull_toy.image}']")
      end

        expect(page).to_not have_link(@dog_bone.name)
        expect(page).to_not have_content(@dog_bone.description)
        expect(page).to_not have_content("Price: $#{@dog_bone.price}")
        expect(page).to_not have_content("Inactive")
        expect(page).to_not have_content("Inventory: #{@dog_bone.inventory}")
        expect(page).to_not have_css("img[src*='#{@dog_bone.image}']")
    end

    it "The item image is a link to that item's show page" do
      visit '/items'

      find(:xpath, "//a/img[@alt='image-#{@tire.id}']/..").click
      expect(current_path).to eq("/items/#{@tire.id}")

      visit '/items'

      find(:xpath, "//a/img[@alt='image-#{@pull_toy.id}']/..").click
      expect(current_path).to eq("/items/#{@pull_toy.id}")
    end

    it "I see an area with statistics" do
      order_1 = Order.create!(name: 'Mick Jagger', address: '123 Rock n Roll Ave', city: 'Los Angeles', state: 'CA', zip: 17033)
      order_2 = Order.create!(name: 'Thom Yorke', address: '123 Karma Police Dr.', city: 'New York', state: 'NY', zip: 17033)
      order_3 = Order.create!(name: 'Sid Vicious', address: '123 Sex Pistols Pl', city: 'Los Angeles', state: 'CA', zip: 17033)

      item_order_1 = order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 6)
      item_order_2 = order_2.item_orders.create!(item: @wheel, price: @wheel.price, quantity: 20)
      item_order_3 = order_3.item_orders.create!(item: @helmet, price: @helmet.price, quantity: 50)
      item_order_4 = order_1.item_orders.create!(item: @helmet, price: @tire.price, quantity: 10)
      item_order_5 = order_2.item_orders.create!(item: @catnip, price: @catnip.price, quantity: 30)
      item_order_6 = order_3.item_orders.create!(item: @catnip, price: @catnip.price, quantity: 10)
      item_order_7 = order_1.item_orders.create!(item: @catnip, price: @catnip.price, quantity: 10)
      item_order_8 = order_1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 1)
      item_order_9 = order_1.item_orders.create!(item: @scratch_pad, price: @scratch_pad.price, quantity: 2)



      visit '/items'

      expect(page).to have_content("Item Statistics:")

      within ".top-5-items-qty-purchased" do
        expect(page).to have_content("The Top 5 - Most Popular Items:")
        expect(page).to have_content("#{@helmet.name} - 60 units purchased")
        expect(page).to have_content("#{@catnip.name} - 50 units purchased")
        expect(page).to have_content("#{@wheel.name} - 20 units purchased")
        expect(page).to have_content("#{@tire.name} - 6 units purchased")
      end

      within ".bottom-5-items-qty-purchased" do
        expect(page).to have_content("The Bottom 5 - Least Popular Items:")
        expect(page).to have_content("#{@pull_toy.name} - 1 units purchased")
        expect(page).to have_content("#{@scratch_pad.name} - 2 units purchased")
        expect(page).to have_content("#{@tire.name} - 6 units purchased")
        expect(page).to have_content("#{@catnip.name} - 20 units purchased")
      end
    end
  end
end
