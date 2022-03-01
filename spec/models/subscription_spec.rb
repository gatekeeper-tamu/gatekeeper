require 'rails_helper'

RSpec.describe Subscription, type: :model do

  it "is valid with valid attributes" do
    FactoryGirl.create(:subscription).should be_valid
  end 

  it "is not valid without user" do
    FactoryGirl.build(:subscription, user: nil).should_not be_valid
  end 

  it "is not valid without username" do
    FactoryGirl.build(:subscription, username: nil).should_not be_valid
  end 

  it "is not valid without password" do
    FactoryGirl.build(:subscription, password: nil).should_not be_valid
  end 
end