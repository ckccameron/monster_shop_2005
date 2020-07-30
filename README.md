**Monster Shop**
**Link to application:** https://evening-beyond-67153.herokuapp.com/

**Description**
Monster Shop is a fictitious e-commerce platform where users can register to place items into a shopping cart and 'check out'. Users who work for a merchant can mark their items as 'fulfilled'; the last merchant to mark items in an order as 'fulfilled' will be able to get "shipped" by an admin. Each user role will have access to some or all CRUD functionality for application models.

**Contributors**
- [Cam Chery](https://github.com/ckccameron)
- [Jessye Ejdelman](https://github.com/ejdelsztejn)
- [Eric Hale](https://github.com/ehale64)
- [Neeru Ram](https://github.com/neeruram1)

**Implementation**
In order to use our Monster Shop, you'll need to follow these steps:

- Rails 5.1.7 (to find out what version you are using, run $ rails -v in the command line)
- Ruby 2.5.x ($ ruby -v)

Next, clone down this repository onto your local machine. Run these commands in order to get required gems and database established.

- ``$ bundle install``
- ``$ bundle update``
- ``$ rake db:create``
- ``$ rake db:migrate``
- ``$ rake db:seed``

To check out our in-depth test suite, run:

- ``$ bundle exec rspec``

**Version Requirements**
- Ruby version - 2.5.3
- Rails version - 5.1.7
- This program uses the gem bcrypt

**Schema Design**

<img width="747" alt="Screen Shot 2020-07-30 at 6 00 56 PM" src="https://user-images.githubusercontent.com/57038617/88979038-1350dc00-d27e-11ea-9ed5-a8dd25113286.png">

**Code Snippets**

- Due to the nested nature of the routes needed to complete this project, we decided to use namespacing in order to make our routes more ReSTful. Additionally, this project required different users to have different levels of access to the site. Namespacing helped us to achieve this in an organized way.
```
namespace :merchant do
    get "/", to: "dashboard#index"
    get "/items", to: "items#index"
    delete "/items/:id", to: "items#destroy"
    get "/items/new", to: "items#new"
    post "/items", to: "items#create"
    patch "/items/:item_id", to: "items#update"
    get "/orders/:order_id", to: "orders#show"
    patch "/item_orders/:item_order_id", to: "item_orders#update"
    get "/items/:item_id/edit", to: "items#edit"

  end

  namespace :admin do
    get "/", to: "dashboard#index"
    get "/users", to: "users#index"
    get "/orders/:order_id", to: "orders#update"
    get "/merchants", to: "merchants#index"
    get "/merchants/:id", to: "merchants#show"
    patch "/merchants/:id", to: "merchants#update"
    get "/merchants/:id/items", to: "items#index"
    delete "/merchants/:merchant_id/items/:item_id", to: "items#destroy"
    get "/merchants/:merchant_id/items/new", to: "items#new"
    post "/merchants/:merchant_id/items/", to: "items#create"
    get "/users/:id", to: "users#show"
  end

  namespace :profile do
    get "/orders", to: "orders#index"
    get "/orders/:id", to: "orders#show"
    patch "/orders/:id", to: "orders#update"
  end
end
```

- Originally, we set up our order status to use string values. However, we decided to overhaul our code and refactor to use enum values to streamline our database referencing and allow us to use ActiveRecord methods. The enum values are set up to use integer values that reference order statuses (i.e 0 = "packaged, 1 = "pending" and so on). 
```
class Order < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  has_many :item_orders
  has_many :items, through: :item_orders
  belongs_to :user

  enum status: %w(packaged pending shipped cancelled)
```

**Acknowledgments**
Our instructors during Module 2 at Turing School:
Meg Stang, Cory Westerfield, Brian Zanti
