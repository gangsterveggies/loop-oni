class UserMailer < ActionMailer::Base
  default from: "loop@oni.dcc.fc.up.pt"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "[Loop@ONI] Repor Password"
  end
end
