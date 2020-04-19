class Credible::InvitationMailer < CredibleMailer
  def invitation_email
    @app_name = Rails.application.class.module_parent_name
    @user = params[:user]
    @url  = root_url
    @invitation_url = @url + 'confirm/' + @user.confirmation_token + '?email=' + @user.email
    mail(to: @user.email, subject: "You have been invited to #{@app_name}")
  end
end
