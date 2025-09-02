class TaxRate
  DEFAULT = 1.10

  def self.calculate_tax_amount(amount)
    BigDecimal(amount.to_s) * BigDecimal((DEFAULT - 1).to_s)
  end

  def self.calculate_total_amount(amount)
    BigDecimal(amount.to_s) * BigDecimal(DEFAULT.to_s)
  end
end
