# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)
#
# # Merchant.destroy_all
# # Item.destroy_all
#
# #merchants
# bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
# dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
#
# #bike_shop items
# tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
#
# #dog_shop items
# pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
# dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
# catnip = dog_shop.items.create(name: "catnip", description: "it'll get you high", price: 5, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 2)
#
# #users
# merchant_user = User.create(name: 'Ross Geller', address: '33 Banana St', city: 'New York', state: 'NY', zip: '12345', email: 'dinosaurs_are_cool@turing.io', password: 'test124', role: 1)
# MerchantUser.create(merchant: bike_shop, user: merchant_user)
# admin_user = User.create(name: 'Napoleon Bonaparte', address: '33 Shorty Ave', city: 'Los Angeles', state: 'CA', zip: '12345', email: 'french_people_rule@turing.io', password: 'test125', role: 2)
# regular_user = User.create(name: 'Neeru Ericsson', address: '33 Cherry St', city: 'Denver', state: 'CO', zip: '12346', email: 'neeru_is_cool@turing.io', password: 'test123')
#
# #orders
# order_1 = Order.create!(name: 'Cam-Eric Ramessye', address: '33 Pineapple St', city: 'New York', state: 'NY', zip: '12345', user: regular_user)
# item_order_1 = order_1.item_orders.create!(item: tire, price: tire.price, quantity: 2)
