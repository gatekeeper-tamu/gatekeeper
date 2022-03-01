require 'rails_helper'
require 'factory_girl_rails'

RSpec.describe User, type: :model do

  it "is valid with valid attributes" do
    FactoryGirl.create(:user).should be_valid
  end 
  
  it "is not valid without a username" do
    FactoryGirl.build(:user, username: nil).should_not be_valid
  end

  it "is not valid without an email" do
    FactoryGirl.build(:user, email: nil).should_not be_valid
  end

  it "is not valid without a password" do
    FactoryGirl.build(:user, password: nil).should_not be_valid
  end

  it "is valid without a first_name" do
    FactoryGirl.build(:user, first_name: nil).should be_valid
  end

  it "is valid without a last_name" do
    FactoryGirl.build(:user, last_name: nil).should be_valid
  end

end
