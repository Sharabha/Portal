class InvitationMailer < ActionMailer::Base
  default from: "sharabha@meeting.ii.uni.wroc.pl"

  def invitation_email(user,token)
    @user  = user
    @token = token
    mail(:to => user.email, :subject => "Team invitation")
  end
end
