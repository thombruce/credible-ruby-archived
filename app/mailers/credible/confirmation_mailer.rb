class Credible::ConfirmationMailer < Credible::MailerBase
  def confirmation_email
    @app_name = Rails.application.class.module_parent_name
    @user = params[:user]
    @confirmation_url = confirmation_url(@user.confirmation_token, email: @user.email)
    mail(to: @user.email, subject: "Welcome to #{@app_name} | Please confirm your account")
  end
end
