require 'rails_helper'

describe ItemOrder, type: :model do
  describe "validations" do
    it { should validate_presence_of :order_id }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :price }
    it { should validate_presence_of :quantity }
  end

  describe "relationships" do
    it {should belong_to :item}
    it {should belong_to :order}
  end

  describe 'instance methods' do
    it 'subtotal' do
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
      item_order_1 = order_1.item_orders.create!(item: tire, price: tire.price, quantity: 2)

      expect(item_order_1.subtotal).to eq(200)
    end
  end

  describe 'class methods' do
    it 'top_5_items' do
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      wheel = meg.items.create(name: "A bike wheel", description: "A super awesome wheel", price: 150, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 25)
      helmet = meg.items.create(name: "Brain Cage", description: "A cage to protect your head", price: 150, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 70)

      pull_toy = brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      catnip = brian.items.create(name: "Catnip", description: "It'll get your cat super high", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 50)
      scratch_pad = brian.items.create(name: "Scratch Pad", description: "Pretty scratchy", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 5)
      dog_bone = brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)


      order_1 = Order.create!(name: 'Mick Jagger', address: '123 Rock n Roll Ave', city: 'Los Angeles', state: 'CA', zip: 17033)
      order_2 = Order.create!(name: 'Thom Yorke', address: '123 Karma Police Dr.', city: 'New York', state: 'NY', zip: 17033)
      order_3 = Order.create!(name: 'Sid Vicious', address: '123 Sex Pistols Pl', city: 'Los Angeles', state: 'CA', zip: 17033)

      item_order_1 = order_1.item_orders.create!(item: tire, price: tire.price, quantity: 6)
      item_order_2 = order_2.item_orders.create!(item: wheel, price: wheel.price, quantity: 20)
      item_order_3 = order_3.item_orders.create!(item: helmet, price: helmet.price, quantity: 50)
      item_order_4 = order_1.item_orders.create!(item: helmet, price: tire.price, quantity: 10)
      item_order_5 = order_2.item_orders.create!(item: catnip, price: catnip.price, quantity: 30)
      item_order_6 = order_3.item_orders.create!(item: catnip, price: catnip.price, quantity: 10)
      item_order_7 = order_1.item_orders.create!(item: catnip, price: catnip.price, quantity: 10)
      item_order_8 = order_1.item_orders.create!(item: pull_toy, price: pull_toy.price, quantity: 1)
      item_order_9 = order_1.item_orders.create!(item: scratch_pad, price: scratch_pad.price, quantity: 2)

      expect(ItemOrder.top_5_items).to eq([helmet, catnip, wheel, tire, scratch_pad])
    end

    it 'bottom_5_items' do
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      wheel = meg.items.create(name: "A bike wheel", description: "A super awesome wheel", price: 150, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 25)
      helmet = meg.items.create(name: "Brain Cage", description: "A cage to protect your head", price: 150, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 70)

      pull_toy = brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      catnip = brian.items.create(name: "Catnip", description: "It'll get your cat super high", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 50)
      scratch_pad = brian.items.create(name: "Scratch Pad", description: "Pretty scratchy", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 5)
      dog_bone = brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)


      order_1 = Order.create!(name: 'Mick Jagger', address: '123 Rock n Roll Ave', city: 'Los Angeles', state: 'CA', zip: 17033)
      order_2 = Order.create!(name: 'Thom Yorke', address: '123 Karma Police Dr.', city: 'New York', state: 'NY', zip: 17033)
      order_3 = Order.create!(name: 'Sid Vicious', address: '123 Sex Pistols Pl', city: 'Los Angeles', state: 'CA', zip: 17033)

      item_order_1 = order_1.item_orders.create!(item: tire, price: tire.price, quantity: 6)
      item_order_2 = order_2.item_orders.create!(item: wheel, price: wheel.price, quantity: 20)
      item_order_3 = order_3.item_orders.create!(item: helmet, price: helmet.price, quantity: 50)
      item_order_4 = order_1.item_orders.create!(item: helmet, price: tire.price, quantity: 10)
      item_order_5 = order_2.item_orders.create!(item: catnip, price: catnip.price, quantity: 30)
      item_order_6 = order_3.item_orders.create!(item: catnip, price: catnip.price, quantity: 10)
      item_order_7 = order_1.item_orders.create!(item: catnip, price: catnip.price, quantity: 10)
      item_order_8 = order_1.item_orders.create!(item: pull_toy, price: pull_toy.price, quantity: 1)
      item_order_9 = order_1.item_orders.create!(item: scratch_pad, price: scratch_pad.price, quantity: 2)

      expect(ItemOrder.bottom_5_items).to eq([pull_toy, scratch_pad, tire, wheel, catnip])
    end

    it ".total_qty" do
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
      item_order_1 = order_1.item_orders.create!(item: tire, price: tire.price, quantity: 2)
      item_order_2 = order_1.item_orders.create!(item: tire, price: tire.price, quantity: 4)

      expect(ItemOrder.total_qty_ordered(tire)).to eq(6)
    end
  end



end
