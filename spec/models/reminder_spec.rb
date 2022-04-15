require 'rails_helper'

RSpec.describe Reminder, type: :model do

  before(:all) do
    @reminder = create(:reminder)
  end

  it "is valid with valid attributes" do
    expect(@reminder).to be_valid
  end

  it "is not valid without subscription" do
    FactoryBot.build(:reminder, subscription_id: nil).should_not be_valid
  end

  it "is not valid without end date" do
    FactoryBot.build(:reminder, end_date: nil).should_not be_valid
  end

  it "is not valid without reminder type" do
    FactoryBot.build(:reminder, reminder_type: nil).should_not be_valid
  end

end
