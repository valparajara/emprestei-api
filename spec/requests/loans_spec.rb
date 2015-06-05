require "rails_helper"

describe LoansController do
  describe "GET /loans" do
    let!(:loans) { create_list(:loan, 2) }
    let(:loans_serialized) { loans.map { |loan| LoanSerializer.new(loan, root: false) }.to_json }

    it "return a 200 status" do
      get loans_path(format: :json)

      expect(status).to eq(200)
    end

    it "return list items lents" do
      get loans_path(format: :json)

      expect(response.body).to eq(loans_serialized)
    end
  end

  describe "POST /loans" do
    let(:loan_serialized) { LoanSerializer.new(Loan.last).to_json }

    context "when I want to create a loan" do
      context "and I create without the required fields" do
        let(:loan) { Loan.new }

        it "returns a 422 status" do
          post loans_path, format: :json, loan: loan.as_json
          expect(status).to eq(422)
        end

        it "returns the loans errors" do
          post loans_path, format: :json, loan: loan.as_json
          loan.save

          expect(response.body).to eq(loan.errors.to_json)
        end
      end

      context "and I create with the required fields" do
        let(:loan) { build(:loan) }

        it "returns a 200 status" do
          post loans_path, format: :json, loan: loan.as_json

          expect(status).to eq(200)
        end

        it "returns the loan serialized" do
          post loans_path, format: :json, loan: loan.as_json

          expect(response.body).to eq(loan_serialized)
        end
      end
    end
  end

  describe "PUT loans/id" do
    let(:loan) { create :loan }
    let(:loan_serialized) { LoanSerializer.new(loan).to_json }

    context "when I whant to edit a item lent" do
      it "and I not fill in required filed" do
        put loan_path(loan), format: :json, loan: { email: " "}

        expect(status).to eq(422)
      end

      it "and I edit successfully" do
        put loan_path(loan), format: :json, loan: loan.as_json

        expect(status).to eq(200)
        expect(response.body).to eq(loan_serialized)
      end
    end
  end

  describe "PUT loans/id/return" do
    let(:loan) { create :loan }

    context "when the loan exist " do
      it "returned get true" do
        get return_loan_path(loan), format: :json
        expect(response.body).to eq("true")

        loan.reload
        expect(loan.returned).to eq(true)
      end
    end
  end
end
