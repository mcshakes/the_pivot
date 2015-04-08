require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "account_creation_confirmation" do
    user = User.create(first_name: "richard", last_name: "mejia", password: "hi", email: "richard@example.com")
    let(:mail) { UserMailer.account_creation_confirmation(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Welcome to the Gallery")
      expect(mail.from).to eq(["gallery@example.com"])
    end
  end

end
