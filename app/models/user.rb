class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable, :confirmable

  has_many :purchases, dependent: :destroy
  has_many :lesson_tickets, dependent: :destroy

  def create_purchase!(ticket_type)
    ticket_price = LessonTicket::TICKET_INFO[ticket_type.to_sym][:price]

    total_amount = TaxRate.calculate_total_amount(ticket_price)
    tax_amount = TaxRate.calculate_tax_amount(ticket_price)
    subtotal = ticket_price

    purchases.create!(
      ticket_type: ticket_type,
      total_amount: total_amount,
      tax_amount: tax_amount,
      subtotal: subtotal
    )
  end
end
