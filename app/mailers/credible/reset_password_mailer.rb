class Credible::ResetPasswordMailer < Credible::MailerBase
  def reset_password_email
    @app_name = Rails.application.class.module_parent_name
    @user = params[:user]
    # TODO: Provide a means to have URL set by user
    @reset_password_url = main_app.root_url + 'confirm/' + @user.confirmation_token + '?email=' + @user.email
    mail(to: @user.email, subject: "Please reset your #{@app_name} password")
  end
end
