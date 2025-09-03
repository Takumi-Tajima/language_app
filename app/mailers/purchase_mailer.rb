class PurchaseMailer < ApplicationMailer
  def request_transfer_email(purchase, user)
    @purchase = purchase
    @user = user
    mail(to: @user.email, subject: '【購入手続きについて】お買い上げありがとうございます')
  end
end
