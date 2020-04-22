class Credible::InvitationMailer < Credible::MailerBase
  def invitation_email
    @app_name = Rails.application.class.module_parent_name
    @user = params[:user]
    @invitation_url = confirmation_url(@user.confirmation_token, email: @user.email)
    mail(to: @user.email, subject: "You have been invited to #{@app_name}")
  end
end
