class LeafeMailer < ApplicationMailer
  helper ApplicationHelper

  def approved(leafe)
    @user = leafe.user
    @leafe = leafe
    mail(to: @user.email, subject: 'Confirmation of Leave!!')
  end

  def rejected(leafe)
    @user = leafe.user
    @leafe = leafe
    mail(to: @user.email, subject: 'Confirmation of Leave!!')
  end

end
