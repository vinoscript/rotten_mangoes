class UserMailer < ApplicationMailer

  default from: 'wstikk@gmail.com'
 
  def delete_email(user)
    @user = user
    @url  = 'http://rottenmangoes.com'
    mail(to: @user.email, subject: 'You Have Been Deleted!')
  end

end
