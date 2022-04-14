require "rails_helper"

RSpec.describe TempAccessMailer, type: :mailer do
  describe "notify" do
    group_member = FactoryBot.create(:user)
    sub = FactoryBot.create(:subscription, user: group_member)
    share_record = FactoryBot.create(:temp_shared_subscription, subscription: sub)
    let(:mail) { TempAccessMailer.share_subscription_email(share_record, sub, group_member.email, group_member) }

    it "renders the headers" do
      expect(mail.subject).to eq("Temporary Account Access on Gatekeeper")
      expect(mail.to).to eq([group_member.email])
      expect(mail.from).to eq(["gatekeeper.tamu@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(sub.subscription_name)
    end
  end
end
