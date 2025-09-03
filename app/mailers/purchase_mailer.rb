class PurchaseMailer < ApplicationMailer
  def payment_request_email(purchase, user)
    @purchase = purchase
    @user = user
    mail(to: @user.email, subject: '【購入手続きについて】お買い上げありがとうございます')
  end

  def payment_confirmed_email(purchase, user)
    @purchase = purchase
    @user = user
    mail(to: @user.email, subject: '【支払い確認】お支払いが確認されました')
  end
end
