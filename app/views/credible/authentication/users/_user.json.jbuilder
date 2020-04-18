json.extract! user, :id, :name, :email, :created_at, :updated_at

json.jwt @session.jwt if @session

json.url user_url(user, format: :json)
