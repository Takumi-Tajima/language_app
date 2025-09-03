class Users::PurchasesController < ApplicationController
  def show
    @purchase = current_user.purchases.find(params.expect(:id))
  end

  def new
  end

  def create
    ticket_type = params.expect(:ticket_type)

    purchase = current_user.purchases.create!(
      ticket_type: ticket_type,
      total_amount: TaxRate.calculate_total_amount(LessonTicket::TICKET_INFO[ticket_type.to_sym][:price]),
      tax_amount: TaxRate.calculate_tax_amount(LessonTicket::TICKET_INFO[ticket_type.to_sym][:price]),
      subtotal: LessonTicket::TICKET_INFO[ticket_type.to_sym][:price]
    )

    redirect_to users_purchase_path(purchase), notice: '購入手続きをしました。メールをご確認ください', status: :see_other
  end
end
