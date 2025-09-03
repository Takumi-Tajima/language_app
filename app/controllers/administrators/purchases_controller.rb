class Administrators::PurchasesController < Administrators::ApplicationController
  before_action :set_purchase, only: %i[show update]

  def index
    @purchases = Purchase.includes(:user).default_order
  end

  def show
  end

  def update
    @purchase.paid! unless @purchase.paid?
    redirect_to administrators_purchase_path(@purchase), notice: '支払いステータスを変更しました。'
  end

  private

  def set_purchase
    @purchase = Purchase.find(params.expect(:id))
  end
end
