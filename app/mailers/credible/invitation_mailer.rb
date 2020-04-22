class Credible::InvitationMailer < Credible::MailerBase
  def invitation_email
    @app_name = Rails.application.class.module_parent_name
    @user = params[:user]
    # TODO: Provide a means to have URL set by user
    @invitation_url = main_app.root_url + '/confirm/' + @user.confirmation_token + '?email=' + @user.email
    mail(to: @user.email, subject: "You have been invited to #{@app_name}")
  end
end
