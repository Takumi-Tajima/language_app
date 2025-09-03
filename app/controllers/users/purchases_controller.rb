class Users::PurchasesController < ApplicationController
  before_action :set_purchase, only: %i[show]

  def index
    @purchases = current_user.purchases.default_order
  end

  def show
  end

  def new
  end

  def create
    ticket_type = params.expect(:ticket_type)
    purchase = current_user.create_purchase!(ticket_type)
    PurchaseMailer.request_transfer_email(purchase, current_user).deliver_later
    redirect_to users_purchase_path(purchase), notice: '購入手続きをしました。メールをご確認ください', status: :see_other
  end

  private

  def set_purchase
    @purchase = current_user.purchases.find(params.expect(:id))
  end
end
