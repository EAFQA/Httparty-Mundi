module Token
  include HTTParty

  base_uri "https://dev.pinbank.com.br/Services/api"
  format :json
  headers "Accept" => " application/json",
          "Content-Type" => "application/x-www-form-urlencoded"
end
