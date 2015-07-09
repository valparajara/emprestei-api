require "rails_helper"

describe Loan do
  describe "when update" do
    let(:user) { create :user, :access_token, :with_loans }

    context "when the item lent is returded" do
      let(:loan) { user.loans.last }

      it "set returned_at" do
        loan.update_attributes(returned: true)
        expect(loan.returned_at).to eq(Date.today)
      end
    end
  end
end
