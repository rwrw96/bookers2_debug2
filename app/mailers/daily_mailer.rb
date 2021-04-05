class DailyMailer < ApplicationMailer
  def daily_email
    @user_emails = User.pluck(:email)
    mail(bcc: @user_emails ,subject: "daily_email:)")
  end
end
