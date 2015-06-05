require "rails_helper"

describe Loan do
  describe "when update" do
    context "when the item lent is returded" do
      subject(:loan) { build :loan, :returned, returned_at: Date.today }

      it "set returned and set returned_at" do
        loan.save
        expect(loan.returned_at).to eq(Date.today)
      end
    end
  end
end
