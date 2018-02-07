class HomeController < ApplicationController
  before_action :authenticate_request
  before_action :check_admin, only: [:card_availability, :assign_card, :employee_transactions]
  include HomeConcern

  def card_availability
    available_cards = Card.available_cards
    available_employees = Employee.available_employees
    render json:{available_cards: available_cards, available_employees: available_employees}, status: :ok
  end

  def assign_card
    begin
      employee = Employee.find assign_card_params[:employee_id]
      card = Card.find assign_card_params[:card_id]
      if employee.card.nil? && card.employee.nil?
        card.employee = employee
        card.save!
        render json: {message: "successfully assigned"}, status: :ok
      else
        render json: {message: "either employee already has a card or card is assigned to some other employee"}, status: :conflict
      end
    rescue Exception => e
      render json: {message: e.message}, status: :bad_request
    end
  end

  def employee_transactions
    begin
      employee = Employee.find employee_transaction_params[:id]
      transactions = employee.transactions
      render json: {transactions: transactions}, status: :ok
    rescue Exception => e
      render json: {message: e.message}, status: :bad_request
    end
  end

  def employee_tax_exmptions
    begin
      transactions = @employee.transactions
      tax_exemptions = prepare_tax_exemption_response
      render json: {transaction_details: transactions, tax_exemptions: tax_exemptions}, status: :ok
    rescue Exception => e
      render json: {meesage: e.message}, status: :bad_request
    end
  end

  
  private

   def assign_card_params
     params.permit(:employee_id, :card_id)
   end

    def employee_transaction_params
      params.permit(:id)
    end

    def check_admin
      render json: {message: "unauthorized access"}, status: :forbidden if !@employee.admin
    end
end
