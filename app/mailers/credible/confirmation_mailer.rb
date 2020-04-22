class Credible::ConfirmationMailer < Credible::MailerBase
  def confirmation_email
    @app_name = Rails.application.class.module_parent_name
    @user = params[:user]
    # TODO: Provide a means to have URL set by user
    @confirmation_url = main_app.root_url + '/confirm/' + @user.confirmation_token + '?email=' + @user.email
    mail(to: @user.email, subject: "Welcome to #{@app_name} | Please confirm your account")
  end
end
