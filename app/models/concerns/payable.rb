module Payable
  extend ActiveSupport::Concern

  included do
    scope :paid, -> { where.not(paid_at: nil) }
    scope :unpaid, -> { where(paid_at: nil) }
  end

  def paid!
    update!(paid_at: Time.current)
  end

  def unpaid!
    update!(paid_at: nil)
  end

  def paid?
    paid_at.present?
  end
end
