class HomeController < ApplicationController
  before_action :authenticate_request
  before_action :check_admin, only: [:card_availability, :assign_card, :employee_transactions, :tax_exemptions]
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
      current_financial_year = FinancialYear.get_financial_year Time.now
      transactions = @employee.transactions
      tax_exemptions = prepare_tax_exemption_response @employee, current_financial_year
      transactions[:tax_exemption] = tax_exemptions
      render json: {transaction_details: transactions}, status: :ok
    rescue Exception => e
      render json: {meesage: e.message}, status: :bad_request
    end
  end

  def tax_exemptions
    begin
      start_date = Date.parse("01-01-#{params[:year]}")
      last_date = Date.parse("31-01-#{params[:year]}")
      financial_year = FinancialYear.where(["start_date <= ? and end_date >= ?", start_date, last_date])
      response = []
      employees = Employee.all
      employees.each do |employee|
        temp = {}
        temp[:id] = employee.id
        temp[:name] = employee.name
        temp[:tax_exemption] = prepare_tax_exemption_response employee, financial_year
        response << temp
      end
      render json: {employee_tax_exmptions: response}
    rescue Exception => e
      render json: {message: e.message}, status: :bad_request
    end
  end



  private

   def assign_card_params
     params.permit(:employee_id, :card_id)
   end

    def employee_transaction_params
      params.permit(:id)
    end

    def tax_exemption_params
      params.permit(:year)
    end

    def check_admin
      render json: {message: "unauthorized access"}, status: :forbidden if !@employee.admin
    end
end
