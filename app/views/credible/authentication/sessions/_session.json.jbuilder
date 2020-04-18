json.extract! session, :id, :created_at, :updated_at

json.jwt session.jwt

# json.url session_url(session, format: :json)
