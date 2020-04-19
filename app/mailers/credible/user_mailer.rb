class Credible::UserMailer < ApplicationMailer
  include Rails.application.routes.url_helpers

  def confirmation_email
    @app_name = Rails.application.class.module_parent_name
    @user = params[:user]
    @url  = root_url
    @confirmation_url = @url + 'confirm/' + @user.confirmation_token + '?email=' + @user.email
    mail(to: @user.email, subject: "Welcome to #{@app_name} | Please confirm your account")
  end

  def invitation_email
    @app_name = Rails.application.class.module_parent_name
    @user = params[:user]
    @url  = root_url
    mail(to: @user.email, subject: "You have been invited to #{@app_name}")
  end
end
