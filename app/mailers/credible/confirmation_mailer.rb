class Credible::ConfirmationMailer < CredibleMailer
  def confirmation_email
    @app_name = Rails.application.class.module_parent_name
    @user = params[:user]
    @url  = root_url
    @confirmation_url = @url + 'confirm/' + @user.confirmation_token + '?email=' + @user.email
    mail(to: @user.email, subject: "Welcome to #{@app_name} | Please confirm your account")
  end
end
