class Users::StripeCheckoutsController < Users::ApplicationController
  def create
    ticket_type = params.expect(:ticket_type)
    session = StripeCheckout.create_session(ticket_type)
    redirect_to session.url, allow_other_host: true, status: :see_other
  end

  def success
    session_id = params.expect(:session_id)
    stripe_session = StripeCheckout.retrieve_session(session_id)
    purchase = current_user.create_purchase!(stripe_session)

    redirect_to users_purchase_path(purchase), notice: 'チケットを購入しました。'
  end
end
