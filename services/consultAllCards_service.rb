module Consultar
  include HTTParty

  base_uri "https://dev.pinbank.com.br/Services/api"
  format :json
end
