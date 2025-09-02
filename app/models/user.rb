class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable, :confirmable

  has_many :purchases, dependent: :destroy
  has_many :lesson_tickets, dependent: :destroy

  def create_purchase!(stripe_session)
    Purchase.create!(
      user: self,
      purchased_at: Time.current,
      total_amount: stripe_session.amount_total,
      tax_amount: TaxRate.calculate_tax_amount(stripe_session.amount_total),
      subtotal: stripe_session.amount_subtotal
    )
  end
end
