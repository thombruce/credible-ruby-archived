json.extract! session, :id, :created_at, :updated_at

json.access_token session.access_token
json.jwt session.access_token
json.refresh_token session.refresh_token

# json.url session_url(session, format: :json)
