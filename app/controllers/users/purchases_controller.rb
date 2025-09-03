class Users::PurchasesController < ApplicationController
  def index
    @purchases = current_user.purchases.default_order
  end

  def show
    @purchase = current_user.purchases.find(params.expect(:id))
  end

  def new
  end

  def create
    ticket_type = params.expect(:ticket_type)
    purchase = current_user.create_purchase!(ticket_type)
    PurchaseMailer.transfer_request_email(purchase, current_user).deliver_later
    redirect_to users_purchase_path(purchase), notice: '購入手続きをしました。メールをご確認ください', status: :see_other
  end
end
