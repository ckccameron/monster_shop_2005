require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    it "I see a nav bar with links to all pages" do
      visit '/'

      within(".topnav") do
        expect(page).to have_link("Home Page")
        expect(page).to have_link("Register")
        expect(page).to have_link("Login")
        expect(page).to have_link("All Merchants")
        expect(page).to have_link("All Items")
        expect(page).to have_link("Cart: 0")
      end
    end
  end
end
