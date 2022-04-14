require "rails_helper"

RSpec.describe NewAccountMailer, type: :mailer do
  describe "notify" do
    group_member = FactoryBot.create(:user)
    let(:mail) { NewAccountMailer.new_account_email(group_member) }

    it "renders the headers" do
      expect(mail.subject).to eq("New Account for Gatekeeper!")
      expect(mail.to).to eq(["gatekeeper.tamu@gmail.com"])
      expect(mail.from).to eq(["gatekeeper.tamu@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("A new account has been created for")
    end
  end
end
