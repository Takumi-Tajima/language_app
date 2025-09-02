class Users::StripeCheckoutsController < Users::ApplicationController
  def create
    ticket_type = params.expect(:ticket_type)
    session = StripeCheckout.create_session(ticket_type)
    redirect_to session.url, allow_other_host: true, status: :see_other
  end
end
