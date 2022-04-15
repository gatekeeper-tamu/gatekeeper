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

  describe "total_cost" do
    user = FactoryBot.create(:user)
    sub = FactoryBot.create(:subscription, user: user, cost_per_month: 9.99)
    
    it "should return total cost of monthly subscriptions" do
      total = user.total_cost()
      expect(total).to be 9.99
    end
  end

  describe "total_cost_overall" do
    user = FactoryBot.create(:user)
    sub = FactoryBot.create(:subscription, user: user, cost_per_month: 5.00, created_at: Time.current - 35.days)
    
    it "should return total overall cost of subscriptions" do
      total = user.total_cost_overall()
      expect(total).to be 10.00
    end
  end

  describe "total_groups" do
    user = FactoryBot.create(:user)
    group1 = FactoryBot.create(:group, owner: user)
    group2 = FactoryBot.create(:group, owner: user)
    
    it "should return number of groups a user has access to" do
      total = user.total_groups()
      expect(total).to be 2
    end
  end

  describe "all_groups" do
    user = FactoryBot.create(:user)

    group1 = FactoryBot.create(:group, owner: user)
    all_groups = user.owned_groups + user.groups
    
    it "should return all groups a user has access to" do
      total = user.all_groups()
      expect(total[0].group_name).to eq(group1.group_name)
    end
  end

  describe "group_cost" do
    user = FactoryBot.create(:user)
    sub = FactoryBot.create(:subscription, user: user, cost_per_month: 5.00, created_at: Time.current - 35.days)
    sub2 = FactoryBot.create(:subscription, user: user, cost_per_month: 10.00, created_at: Time.current)
    group1 = FactoryBot.create(:group, owner: user, subscriptions: [sub, sub2])
    
    it "should return total monthly cost" do
      total = user.group_cost(group1)
      expect(total).to be 15.00
    end
  end

end
