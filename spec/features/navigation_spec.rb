
require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    it "I see a nav bar with links to all pages" do
      visit '/merchants'

      within 'nav' do
        click_link 'All Items'
      end

      expect(current_path).to eq('/items')

      within 'nav' do
        click_link 'All Merchants'
      end

      expect(current_path).to eq('/merchants')
    end

    it "I can see a cart indicator on all pages" do
      visit '/merchants'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end

      visit '/items'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end
    end
  end

  describe 'As a merchant employee' do
    it 'displays nav bar with same links as a regular user including a link to merchant dashboard' do
      merchant = User.create(name: 'Ross Geller',
                            address: '33 Banana St',
                            city: 'New York',
                            state: 'NY',
                            zip: '12345',
                            email: 'dinosaurs_are_cool@turing.io',
                            password: 'test124',
                            role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit '/merchants'

      within 'nav' do
        click_link 'Merchant Dashboard'
      end

      expect(current_path).to eq('/merchant')

      # click_link 'Home'
      # expect(current_path).to eq('/')
      # click_link 'All Merchants'
      # expect(current_path).to eq('/merchants')
      # click_link 'All Items'
      # expect(current_path).to eq('/items')
      # click_link 'Log out'
      # expect(current_path).to eq('/')
    end

    it "cannot access /admin" do
      merchant = User.create(name: 'Ross Geller',
                            address: '33 Banana St',
                            city: 'New York',
                            state: 'NY',
                            zip: '12345',
                            email: 'dinosaurs_are_cool@turing.io',
                            password: 'test124',
                            role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit "/admin"

      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end
  end

  describe 'As an admin' do
    it 'displays nav bar with same links as regular user including admin specfic links' do
      admin = User.create(name: 'Napoleon Bonaparte',
                          address: '33 Shorty Ave',
                          city: 'Los Angeles',
                          state: 'CA',
                          zip: '12345',
                          email: 'french_people_rule@turing.io',
                          password: 'test125',
                          role: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/merchants'

      within 'nav' do
        click_link 'Home'
      end

      expect(current_path).to eq('/')

      within 'nav' do
        click_link 'All Merchants'
      end

      expect(current_path).to eq('/merchants')

      within 'nav' do
        click_link 'All Items'
      end

      expect(current_path).to eq('/items')

      within 'nav' do
        click_link 'Admin Dashboard'
      end

      expect(current_path).to eq('/admin')

      within 'nav' do
        click_link 'All Users'
      end

      expect(current_path).to eq('/admin/users')

      within 'nav' do
        expect(page).to_not have_content('Cart: 0')
      end
    end
  end
end
