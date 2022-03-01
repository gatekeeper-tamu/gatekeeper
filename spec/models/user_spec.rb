require 'rails_helper'
require 'factory_bot_rails'

RSpec.describe User, type: :model do

  it "is valid with valid attributes" do
    FactoryBot.create(:user).should be_valid
  end 
  
  it "is not valid without a username" do
    FactoryBot.build(:user, username: nil).should_not be_valid
  end

  it "is not valid without an email" do
    FactoryBot.build(:user, email: nil).should_not be_valid
  end

  it "is not valid without a password" do
    FactoryBot.build(:user, password: nil).should_not be_valid
  end

  it "is valid without a first_name" do
    FactoryBot.build(:user, first_name: nil).should be_valid
  end

  it "is valid without a last_name" do
    FactoryBot.build(:user, last_name: nil).should be_valid
  end

  it "does not allow duplicate usernames" do
    username = "testerwoman"
    FactoryBot.create(:user, username: username)
    FactoryBot.build(:user, username: username).should_not be_valid
  end

  it "does not allow duplicate emails" do
    email = "test@test.com"
    FactoryBot.create(:user, email: email)
    FactoryBot.build(:user, email: email).should_not be_valid
  end

end
