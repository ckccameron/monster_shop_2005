require 'rails_helper'

describe MerchantUser, type: :model do
  describe "validations" do
    it { should belong_to :merchant }
    it { should belong_to :user }
  end
end
