class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :update]

  def index
    loans = Loan.all

    respond_to do |format|
      format.json { render json: loans, root: false }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: set_loan }
    end
  end

  # POST /loans.json
  def create
    @loan = Loan.new(loan_params)

    respond_to do |format|
      if @loan.save
        format.json { render json: @loan }
      else
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loans/1.json
  def update
    respond_to do |format|
      if @loan.update_attributes(loan_params)
        format.json { render json: @loan }
      else
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET loans/id/return
  def return
    return_loan = set_loan.update_attributes(returned: true)

    respond_to do |format|
      format.json { render json: return_loan }
    end
  end

  private
    def set_loan
      @loan = Loan.find(params[:id])
    end

    def loan_params
      params.require(:loan).permit(:_id, :email, :item_lent, :created_at, :returned, :returned_at)
    end
end