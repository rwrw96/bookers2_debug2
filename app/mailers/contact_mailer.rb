class ContactMailer < ApplicationMailer
  
 def welcome_email
   @user = params[:user]
   mail(to: @user.email, subject: 'welcome to my family!')
 end
end
