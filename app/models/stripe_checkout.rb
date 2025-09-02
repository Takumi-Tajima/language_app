class StripeCheckout
  def self.create_session(ticket_type)
    ticket_info = LessonTicket::TICKET_INFO[ticket_type.to_sym]
    lesson_count = ticket_info[:count]
    price = TaxRate.calculate_total_amount(ticket_info[:price]).to_i

    ::Stripe::Checkout::Session.create(
      success_url: 'http://localhost:3000/users/stripe_checkouts/success?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: 'http://localhost:3000/users/purchases',
      mode: 'payment',
      line_items: [
        {
          price_data: {
            currency: 'jpy',
            product_data: {
              name: "レッスンチケット#{lesson_count}回分",
            },
            unit_amount: price,
          },
          quantity: 1,
        },
      ],
      metadata: {
        ticket_type: ticket_type,
      }
    )
  end

  def self.retrieve_session(session_id)
    ::Stripe::Checkout::Session.retrieve(session_id)
  end
end
