require 'rails_helper'

RSpec.describe Group, type: :model do

  it "is valid with valid attributes" do
    FactoryBot.create(:group).should be_valid
  end

  it "is not valid without owner" do
    FactoryBot.build(:group, owner: nil).should_not be_valid
  end

  it "is valid with members" do
    group = FactoryBot.build(:group_with_members)
    group.should be_valid
    expect(group.users.length > 0)
  end

  it "is valid with subscriptions" do
    group = FactoryBot.build(:group_with_subscriptions)
    group.should be_valid
    expect(group.subscriptions.length > 0)
  end
end
