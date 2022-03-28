require 'rails_helper'

RSpec.describe Reminder, type: :model do

  it "is valid with valid attributes" do
    FactoryBot.create(:reminder).should be_valid
  end

  it "is not valid without subscription" do
    FactoryBot.build(:reminder, subscription_id: nil).should_not be_valid
  end
end
