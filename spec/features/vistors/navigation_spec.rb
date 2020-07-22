require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    it "I see a nav bar with links to all pages" do
      visit '/'

      within(".topnav") do
        expect(page).to have_link("Home Page")
        expect(page).to have_link("All Items for Sale")
        expect(page).to have_link("All Merchants")
        expect(page).to have_link("Cart")
        expect(page).to have_content("Items in Cart: 0")
        expect(page).to have_link("Login")
        expect(page).to have_link("Register")
      end
    end
  end
end
