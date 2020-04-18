class Credible::UserMailer < Credible::ApplicationMailer
  # TODO: Decouple from Settings in inheriting application.
  # QUESTION: How then will we set the URL?

  include Rails.application.routes.url_helpers

  def confirmation_email
    @settings = Settings.instance
    @user = params[:user]
    @url  = root_url(host: @settings.hostname)
    @confirmation_url = @url + 'confirm/' + @user.confirmation_token
    mail(from: @settings.email, to: @user.email, subject: "Welcome to #{@settings.name} | Please confirm your account")
  end

  def invitation_email
    @settings = Settings.instance
    @user = params[:user]
    @url  = root_url(host: @settings.hostname)
    mail(from: @settings.email, to: @user.email, subject: "You have been invited to #{@settings.name}")
  end
end
