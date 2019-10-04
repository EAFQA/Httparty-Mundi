module Consultar
  include HTTParty

  base_uri "https://dev.pinbank.com.br/Services/api"
  format :json
end

def token(grant_type, username, password)
  @body =
    {
      grant_type: grant_type,
      username: username,
      password: password,
    }
  @token = Token.post("/token", body: @body)
end
