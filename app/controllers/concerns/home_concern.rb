module HomeConcern

  def prepare_tax_exemption_response
    response = []
    financial_year = FinancialYear.get_financial_year Time.now
    limits = financial_year.months_limits.includes(:mcc_code)
    spendings = @employee.spendings.where(months_limits: limits)
    limits.each do |limit|
      temp = {}
      temp[:month] = limit[:month]
      temp[:limit] = limit[:limit]
      temp[:merchant_name] = limit.mcc_code.name
      temp[:total_spending] = @employee.month_wise_spending limit.id
      response << temp
    end
    response
  end

end
