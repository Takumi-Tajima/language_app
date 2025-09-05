class BookingMailer < ApplicationMailer
  def booking_confirmation_email_to_user(booking, user)
    @booking = booking
    @user = user
    mail(to: @user.email, subject: '【予約確認】ご予約ありがとうございます')
  end

  def booking_notification_email_to_instructor(booking, instructor, user)
    @user = user
    @booking = booking
    @instructor = instructor
    mail(to: @instructor.email, subject: '【予約通知】新しいレッスン予約が入りました')
  end
end
