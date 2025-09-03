class Administrators::PurchasesController < Administrators::ApplicationController
  before_action :set_purchase, only: %i[show]

  def index
    @purchases = Purchase.includes(:user).default_order
  end

  def show
  end

  private

  def set_purchase
    @purchase = Purchase.find(params.expect(:id))
  end
end
