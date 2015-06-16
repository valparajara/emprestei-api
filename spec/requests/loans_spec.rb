require "rails_helper"

describe LoansController do

  describe "GET /loans" do

    let(:user) { create :user, :access_token, :with_loans }
    let(:user_params) { { user: { access_token: user.access_token } } }

    context "when no access token is given" do
      it "returns 401 error" do
        get loans_path(format: :json)

        expect(response.status).to eq(401)
      end
    end

    context "when passing an access token" do
      let(:loan_serialized) { user.loans.map { |loan| LoanSerializer.new(loan)} }

      context "that is not valid" do
        it "returns 401 error" do
          get loans_path(format: :json), access_token: 'invalid'

          expect(response.status).to eq(401)
        end
      end

      context "that is valid" do
        it "return a 200 status" do
          get loans_path, format: :json, access_token: user.access_token

          expect(status).to eq(200)
        end
        it "return list items lents" do
          get loans_path, format: :json, access_token: user.access_token

          expect(response.body).to eq(loan_serialized.to_json(root: false))
        end
      end
    end
  end

  describe "POST /loans" do

    let(:user) { create :user, :access_token }
    let(:user_params) { { user: { access_token: user.access_token } } }

    context "when I want to create a loan" do

      context "when passing access token" do
        it "that is not valid" do
          post loans_path(format: :json), access_token: 'invalid'

          expect(response.status).to eq(401)
        end
      end

      context "when passing an access token valid" do
        let(:loan_serialized) { LoanSerializer.new(user.loans.last).to_json }

        context "and I create without the required fields" do
          let(:loan) { Loan.new }

          it "returns a 422 status" do
            post loans_path, format: :json, loan: loan.as_json, access_token: user.access_token

            expect(status).to eq(422)
          end

          it "returns the loans errors" do
            post loans_path, format: :json, loan: loan.as_json, access_token: user.access_token
            loan.save

            expect(response.body).to eq(loan.errors.to_json)
          end
        end

        context "and I create with the required fields" do
          subject(:loan) { user.loans.build(friend_email: "teste@teste.com", loaned_item: "Emprestimo teste") }

          it "returns a 200 status" do
            post loans_path, format: :json, loan: loan.as_json, access_token: user.access_token

            expect(status).to eq(200)
          end

          it "returns the loan serialized" do
            post loans_path, format: :json, loan: loan.as_json, access_token: user.access_token

            expect(response.body).to eq(loan_serialized)
          end
        end
      end
    end
  end

  describe "PUT loans/id" do

    let(:user) { create :user, :access_token, :with_loans }
    let(:user_params) { { user: { access_token: user.access_token } } }

    let(:loan) { user.loans.last }
    let(:loan_serialized) { LoanSerializer.new(loan).to_json }

    context "when passing access token" do
      it "that is not valid" do
        post loans_path(format: :json), access_token: 'invalid'

        expect(response.status).to eq(401)
      end

      context "that is valid" do
        context "when I whant to edit a item lent" do
          it "and I not fill in required filed" do
            put loan_path(loan), format: :json, loan: {  friend_email: "" }, access_token: user.access_token

            expect(status).to eq(422)
          end

          it "and I edit successfully" do
            put loan_path(loan), format: :json, loan: loan.as_json, access_token: user.access_token

            expect(status).to eq(200)
            expect(response.body).to eq(loan_serialized)
          end
        end
      end
    end
  end

  describe "PUT loans/id/return" do
    let(:user) { create :user, :access_token, :with_loans }
    let(:user_params) { { user: { access_token: user.access_token } } }

    let(:loan) { user.loans.last }
    let(:loan_serialized) { LoanSerializer.new(loan).to_json }

    context "when the loan exist " do
      it "returned get true" do
        get return_loan_path(loan), format: :json, access_token: user.access_token
        expect(response.body).to eq("true")

        loan.reload
        expect(loan.returned).to eq(true)
      end
    end
  end
end
