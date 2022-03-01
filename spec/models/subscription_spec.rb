require 'rails_helper'

RSpec.describe Subscription, type: :model do

  it "is valid with valid attributes" do
    FactoryBot.create(:subscription).should be_valid
  end

  it "is not valid without user" do
    FactoryBot.build(:subscription, user: nil).should_not be_valid
  end

  it "is not valid without username" do
    FactoryBot.build(:subscription, username: nil).should_not be_valid
  end

  it "is not valid without password" do
    FactoryBot.build(:subscription, password: nil).should_not be_valid
  end
end