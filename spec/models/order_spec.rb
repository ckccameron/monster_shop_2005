require 'rails_helper'

describe Order, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "relationships" do
    it {should have_many :item_orders}
    it {should have_many(:items).through(:item_orders)}
    it {should belong_to :user}
  end

  describe "instance methods" do
    before :each do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @regular_user = User.create(name: 'Neeru Ericsson', address: '33 Cherry St', city: 'Denver', state: 'CO', zip: '12346', email: 'neeru_is_cool@turing.io', password: 'test123', role: 0)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

      @order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user: @regular_user, status: "pending")

      @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @order_1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3)
    end

    it 'grandtotal' do
      expect(@order_1.grandtotal).to eq(230)
    end

    it "total_items" do
      expect(@order_1.total_items).to eq(2)
    end
  end

  describe "class methods" do
    it ".status_packaged" do
      regular_user = User.create(name: 'Neeru Ericsson', address: '33 Cherry St', city: 'Denver', state: 'CO', zip: '12346', email: 'neeru_is_cool@turing.io', password: 'test123', role: 0)

      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      helmet = meg.items.create(name: "Brain Cage", description: "A cage to protect your head", price: 150, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 70)
      catnip = brian.items.create(name: "Catnip", description: "It'll get your cat super high", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 50)

      order = Order.create!(name: 'Sid Vicious', address: '123 Sex Pistols Pl', city: 'Los Angeles', state: 'CA', zip: 17033, user: regular_user)

      item_order_1 = order.item_orders.create!(item: helmet, price: helmet.price, quantity: 50)
      item_order_2 = order.item_orders.create!(item: catnip, price: catnip.price, quantity: 10)

      expect(order.status).to eq("pending")

      order.status_packaged

      expect(order.status).to eq("packaged")
    end

    it ".packaged_orders" do
      regular_user = User.create(name: 'Neeru Ericsson', address: '33 Cherry St', city: 'Denver', state: 'CO', zip: '12346', email: 'neeru_is_cool@turing.io', password: 'test123', role: 0)

      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      helmet = meg.items.create(name: "Brain Cage", description: "A cage to protect your head", price: 150, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 70)
      catnip = brian.items.create(name: "Catnip", description: "It'll get your cat super high", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 50)
      scratch_pad = brian.items.create(name: "Scratch Pad", description: "Pretty scratchy", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 5)
      dog_bone = brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

      order_1 = regular_user.orders.create!(name: "Neeru Ericsson", address: "33 Cherry St", city: "Denver", state: "CO", zip: "12346", status: 0)
      order_1.item_orders.create(order: order_1, item: catnip, price: catnip.price, quantity: 2)

      order_2 = regular_user.orders.create!(name: "Neeru Ericsson", address: "33 Cherry St", city: "Denver", state: "CO", zip: "12346", status: 3)
      order_2.item_orders.create(order: order_2, item: scratch_pad, price: scratch_pad.price, quantity: 2)

      order_3 = regular_user.orders.create!(name: "Neeru Ericsson", address: "33 Cherry St", city: "Denver", state: "CO", zip: "12346", status: 1)
      order_3.item_orders.create(order: order_3, item: dog_bone, price: dog_bone.price, quantity: 2)

      order_4 = regular_user.orders.create!(name: "Neeru Ericsson", address: "33 Cherry St", city: "Denver", state: "CO", zip: "12346", status: 0)
      order_4.item_orders.create(order: order_4, item: dog_bone, price: dog_bone.price, quantity: 2)

      expect(Order.packaged_orders).to eq([order_1, order_4])
    end
  end
end
