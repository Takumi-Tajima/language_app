class Users::PurchasesController < Users::ApplicationController
  before_action :set_purchases, only: %i[show]

  def show
  end

  def new
  end

  private

  def set_purchases
    @purchase = current_user.purchases.find(params.expect(:id))
  end
end
