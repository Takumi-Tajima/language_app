class Administrators::PurchasesController < Administrators::ApplicationController
  before_action :set_purchase, only: %i[show update]

  def index
    @purchases = Purchase.includes(:user).default_order
  end

  def show
  end

  def update
    if @purchase.paid!
      PurchaseMailer.payment_confirmed_email(@purchase, @purchase.user).deliver_later
      redirect_to administrators_purchase_path(@purchase), notice: '支払いステータスを変更しました。'
    else
      redirect_to administrators_purchase_path(@purchase), alert: 'すでに支払い確認済みです。'
    end
  end

  private

  def set_purchase
    @purchase = Purchase.find(params.expect(:id))
  end
end
