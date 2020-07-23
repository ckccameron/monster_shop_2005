require 'rails_helper'

RSpec.describe 'As a registered user, merchant, or admin', type: :feature do
  describe 'When I visit the login path' do
    it "If I am a regular user, I am redirected to my profile page" do
      user = User.create(name: "Dobby",
                        address: '23 Hogwarts Ave',
                        city: 'Glasgow',
                        state: 'Scotland',
                        zip: '23456',
                        email: 'elvz_rule@owl.io',
                        password: "h@rrypotterisindanger!",
                        role: 0)

      expect(user.role).to eq("default")
      expect(user.default?).to be_truthy

      visit '/login'

      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_on "Submit Information"
      expect(current_path).to eq("/profile")
      visit '/login'
      expect(page).to have_content("You are already logged in")
    end

    it "If I am a merchant user, I am redirected to my merchant dashboard page" do
      merchant = User.create(name: "Honeydukes",
                                address: '123 Hogsmeade Ln.',
                                city: 'Hogsmeade',
                                state: 'Scotland',
                                zip: '80203',
                                email: '2sweet@owl.io',
                                password: "everyeeeflavour!",
                                role: 1)

      expect(merchant.role).to eq("merchant")
      expect(merchant.merchant?).to be_truthy

      visit '/login'

      fill_in :email, with: merchant.email
      fill_in :password, with: merchant.password
      click_on "Submit Information"
      expect(current_path).to eq("/merchant")
      visit '/login'
      expect(page).to have_content("You are already logged in")
    end

    it "If I am an admin user, I am redirected to my admin dashboard page" do
      admin = User.create(name: "Dumbledore",
                        address: '100 Hogwarts Ave',
                        city: 'Glasgow',
                        state: 'Scotland',
                        zip: '23456',
                        email: 'headmaster@owl.io',
                        password: "beardsRkewl168",
                        role: 2)

      expect(admin.role).to eq("admin")
      expect(admin.admin?).to be_truthy

      visit '/login'

      fill_in :email, with: admin.email
      fill_in :password, with: admin.password
      click_on "Submit Information"
      expect(current_path).to eq("/admin")
      visit '/login'
      expect(page).to have_content("You are already logged in")
    end
  end
end
