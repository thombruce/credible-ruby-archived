class Credible::ResetPasswordMailer < CredibleMailer
  def reset_password_email
    @app_name = Rails.application.class.module_parent_name
    @user = params[:user]
    @url  = root_url
    @reset_password_url = @url + 'confirm/' + @user.confirmation_token + '?email=' + @user.email
    mail(to: @user.email, subject: "Please reset your #{@app_name} password")
  end
end
