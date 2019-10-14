class ApiToken
  include HTTParty
  base_uri "https://dev.pinbank.com.br/Services/api"
  headers "Accept" => " application/json",
          "Content-Type" => "application/x-www-form-urlencoded"

  def self.token(grant_type, user_name, user_pass)
    @result = post("/token", body: { grant_type: grant_type, username: user_name, userpass: user_pass })
    "bearer #{result.parsed_response["access_token"]}"
  end

  def self.save(token)
    post("/token", body: token)
  end

  def self.find(token)
    post("/Transacoes/IncluirCartao", headers: { "Authorization" => token,
                                                 "Content-Type" => "application/x-www-form-urlencoded",
                                                 "UserName" => "Yj3b0CsopkBR",
                                                 "RequestOrigin" => "5" })
  end
end
