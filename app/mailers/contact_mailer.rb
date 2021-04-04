class ContactMailer < ApplicationMailer
　def send_when_admin_reply(user)
    @user = user
    mail to: user.email, subject: 'ご登録ありがとうございます'
　end
end
