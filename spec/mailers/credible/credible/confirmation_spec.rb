require "rails_helper"

module Credible
  RSpec.describe Credible::ConfirmationMailer, type: :mailer do
    describe "confirmation_email" do
      let(:mail) { described_class.with(app_name: 'Spec App', user: ::User.create(email: 'test@example.com', password: 'Password123!')).confirmation_email }
  
      it "renders the headers" do
        expect(mail.subject).to match("Welcome to Spec App")
        expect(mail.to).to eq(["test@example.com"])
        expect(mail.from).to eq(["from@example.com"])
      end
  
      it "renders the body" do
        expect(mail.body.encoded).to match("You have successfully signed up to")
      end
    end
  end
end
