json.extract! user, :id, :email, :created_at, :updated_at

if @session
  json.access_token @session.access_token
  json.jwt @session.access_token

  json.refresh_token @session.refresh_token
end

json.url user_url(user, format: :json)
