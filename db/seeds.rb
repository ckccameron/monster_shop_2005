# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Merchant.destroy_all
#Item.destroy_all

#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)		 pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)		 dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

#users
user_1 = User.create(name: 'Neeru Ericsson', address: '33 Cherry St', city: 'Denver', state: 'CO', zip: '12346', email: 'neeru_is_cool@turing.io', password: 'test123', role: 0)
user_2 = User.create(name: "Dobby", address: '23 Hogwarts Ave', city: 'Glasgow', state: 'Scotland', zip: '23456', email: 'elvz_rule@owl.io', password: "h@rrypotterisindanger!", role: 0)
user_3 = User.create(name: "Dumbledore", address: '23 Hogwarts Ave', city: 'Glasgow', state: 'Scotland', zip: '23456', email: 'wandmaster@hogwarts.io', password: "fawkesthephoenix!", role: 2)

#orders
order_1 = Order.create!(name: 'Neeru Ericsson', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user: user_1, status: "pending")
order_2 = Order.create!(name: 'Dobby', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user: user_2, status: "pending")

#item_orders
item_order_1 = order_1.item_orders.create!(item: pull_toy, price: pull_toy.price, quantity: 2)
item_order_2 = order_1.item_orders.create!(item: dog_bone, price: dog_bone.price, quantity: 4)
item_order_3 = order_2.item_orders.create!(item: pull_toy, price: pull_toy.price, quantity: 5)
item_order_4 = order_2.item_orders.create!(item: dog_bone, price: dog_bone.price, quantity: 4)
item_order_5 = order_2.item_orders.create!(item: tire, price: tire.price, quantity: 5)
