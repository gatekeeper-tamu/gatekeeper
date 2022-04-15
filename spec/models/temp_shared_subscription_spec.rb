require 'rails_helper'

RSpec.describe TempSharedSubscription, type: :model do

  it "is valid with valid attributes" do
    FactoryBot.create(:temp_shared_subscription).should be_valid
  end

  it "is valid without end_date" do
    FactoryBot.build(:temp_shared_subscription, end_date: nil).should be_valid
  end

  it "is not valid without subscription" do
    FactoryBot.build(:temp_shared_subscription, subscription: nil).should_not be_valid
  end
end
