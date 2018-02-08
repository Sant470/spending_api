module HomeConcern

  def prepare_tax_exemption_response employee, financial_year
    response = []
    financial_year = FinancialYear.get_financial_year Time.now
    limits = financial_year.months_limits.includes(:mcc_code)
    limits.each do |limit|
      temp = {}
      temp[:month] = limit[:month]
      temp[:limit] = limit[:limit]
      temp[:merchant_name] = limit.mcc_code.name
      #need to retrive from single query
      temp[:total_spending] = employee.month_wise_spending limit.id
      response << temp
    end
    response
  end


end
