# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)
#

ItemOrder.destroy_all
Order.destroy_all
User.destroy_all
Merchant.destroy_all
Item.destroy_all

#users
@regular_user_1 = User.create(name: 'Neeru Ericsson', address: '33 Cherry St', city: 'Denver', state: 'CO', zip: '12346', email: 'neeru_is_cool@turing.io', password: 'test123', role: 0)
@regular_user_2 = User.create(name: 'Eric Neeruson Jr', address: '123 South St', city: 'Boston', state: 'MA', zip: '01770', email: 'eric_is_cooler@turing.io', password: 'password1', role: 0)
@regular_user_3 = User.create(name: 'Bob Marley', address: '100 Rasta Market Ave', city: 'Jamaica Queens', state: 'NY', zip: '11432', email: 'dont_worry123@marley.gov', password: 'marley1', role: 0)
@merchant_user_1 = User.create(name: 'Ross Geller', address: '33 Banana St', city: 'New York', state: 'NY', zip: '12345', email: 'dinosaurs_are_cool@turing.io', password: 'test124', role: 1)
@merchant_user_2 = User.create(name: 'David Geronimo Cox', address: '235 4th St', city: 'Louisville', state: 'KY', zip: '40018', email: 'smoke_up@ky.gov', password: 'lightemup3', role: 1)
@admin_user_1 = User.create(name: 'Napoleon Bonaparte', address: '33 Shorty Ave', city: 'Washington', state: 'DC', zip: '12345', email: 'french_people_rule@turing.io', password: 'test125', role: 2)
@admin_user_2 = User.create(name: 'Louis The Fourth', address: '43 Shorty Ave', city: 'Washington', state: 'DC', zip: '12345', email: 'french_people_drool@turing.io', password: '125test', role: 2)

#merchants
@meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
@brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
@mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
@cox = Merchant.create(name: "Cox Smoker's Outlet", address: '789 Puffy Ave', city: 'Louisville', state: 'KY', zip: 40018)

#items
@pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
@catnip = @brian.items.create(name: "Catnip", description: "It'll get your cat super high", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 50)
@dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
@cat_collar = @brian.items.create(name: "Cat Collar", description: "Bling bling for your favorite cat!", price: 25, image: "https://www.lupinepet.com/store/pub/media/catalog/product/cache/35fa0eddc4c5b447d3049c99584ff161/s/t/stack.jpg", inventory: 15)
@scratch_pad = @mike.items.create(name: "Scratch Pad", description: "Scribble your thoughts!", price: 8, image: "https://imgs.michaels.com/MAM/assets/1/726D45CA1C364650A39CD1B336F03305/img/8B6A590E6FC34D0291151BD7A4DC54DF/10014390.jpg", inventory: 20)
@pack_of_cigs = @cox.items.create(name: "Pack of Cigs", description: "Smoke your sorrows away!", price: 20, image: "https://scontent.harristeeter.com/legacy/productimagesroot/DJ/3/493233.jpg", inventory: 30)
@bourbon = @cox.items.create(name: "Four Roses Bourbon Whiskey", description: "It'll knock you out!", price: 25, image: "https://nanzandkraft.imgix.net/images/itemVariation/FOURROSES2020-200206113330.png?auto=format&w=425&h=500&fit=crop", inventory: 5)
@cigarillos = @cox.items.create(name: "Cuban Cigarillos", description: "COVID will love you - maybe not such a good thing!", price: 155, image: "https://robbreportedit.files.wordpress.com/2018/08/06_rr_botb_cigars_la-aurora.jpg?w=660", inventory: 15)
@yoga_mat = @meg.items.create(name: "Assorted Yoga Mats", description: "Reach for your goals!", price: 20, image: "https://www.yogaaccessories.com/assets/images/1_4inch%20yoga%20mat_website.jpg", inventory: 10)
@brake_pads = @meg.items.create(name: "Brake Pads", description: "Stop...in the name of love!", price: 40, image: "https://fitzgeraldmuseum.net/wp-content/uploads/2018/05/10.-Pangda-2-Pairs-Road-Brake-Pads-with-Installation-Tool-Caliper-Brake-Blocks-50-mm.jpg", inventory: 15)
@bike_pump = @meg.items.create(name: "Bike Pump", description: "Pump it up!", price: 250, image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTZ9bOgRRxxY-r4VGrP3JMU6NEHPAnqlw88-TACvPZoqtUv55PBfFkZhtjr0rY&usqp=CAc", inventory: 8)

#orders
@order_1 = @regular_user_1.orders.create(name: "Neeru Ericsson", address: "33 Cherry St", city: "Denver", state: "CO", zip: "12346", status: 2)
@order_1.item_orders.create(order: @order_1, item: @pull_toy, price: @pull_toy.price, quantity: 2)

@order_2 = @regular_user_1.orders.create(name: "Grandma", address: "555 Cherry Pie St", city: "Boston", state: "MA", zip: "01770", status: 2)
@order_2.item_orders.create(order: @order_2, item: @catnip, price: @catnip.price, quantity: 7)
@order_2.item_orders.create(order: @order_2, item: @cat_collar, price: @cat_collar.price, quantity: 1)

@order_3 = @regular_user_3.orders.create(name: "Jesseeru Mendez", address: "241 Silver St", city: "Springfield", state: "MA", zip: "02445", status: 3)
@order_3.item_orders.create(order: @order_3, item: @scratch_pad, price: @scratch_pad.price, quantity: 2)
@order_3.item_orders.create(order: @order_3, item: @pack_of_cigs, price: @pack_of_cigs.price, quantity: 5)

@order_4 = @regular_user_3.orders.create(name: "Neeru Ericsson", address: "33 Cherry St", city: "Denver", state: "CO", zip: "12346", status: 0)
@order_4.item_orders.create(order: @order_4, item: @dog_bone, price: @dog_bone.price, quantity: 2)

@order_5 = @regular_user_2.orders.create(name: "Aric Arickson", address: "345 Main St", city: "Denver", state: "CO", zip: "80205", status: 1)
@order_5.item_orders.create(order: @order_5, item: @yoga_mat, price: @yoga_mat.price, quantity: 12)

@order_6 = @regular_user_2.orders.create(name: "Aric Arickson", address: "345 Main St", city: "Denver", state: "CO", zip: "80205", status: 1)
@order_6.item_orders.create(order: @order_6, item: @bike_pump, price: @bike_pump.price, quantity: 1)
@order_6.item_orders.create(order: @order_6, item: @bourbon, price: @bourbon.price, quantity: 3)
