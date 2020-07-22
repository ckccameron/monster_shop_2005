require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    it "can see a nav bar with links to all pages" do
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
    it "cannot access merchant, admin, or profile pages" do
      visit '/'

      visit '/merchant'
      expect(page).to have_content("404 Error: Content not found")

      visit '/admin'
      expect(page).to have_content("404 Error: Content not found")

      visit '/profile'
      expect(page).to have_content("404 Error: Content not found")
    end
  end
end
