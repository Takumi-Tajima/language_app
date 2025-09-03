class Users::PurchasesController < ApplicationController
  def show
    @purchase = current_user.purchases.find(params.expect(:id))
  end

  def new
  end

  def create
    ticket_type = params.expect(:ticket_type)
    purchase = current_user.create_purchase!(ticket_type)
    redirect_to users_purchase_path(purchase), notice: '購入手続きをしました。メールをご確認ください', status: :see_other
  end
end
