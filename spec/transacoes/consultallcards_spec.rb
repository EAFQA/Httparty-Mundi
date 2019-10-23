describe "post" do
  def token(grant_type, username, password)
    @body =
      {
        grant_type: grant_type,
        username: username,
        password: password,
      }
    @token = Token.post("/token", body: @body)
  end

  context "consultar todos cartoes" do
    before { token("password", "Yj3b0CsopkBR", "umo1LNtje0Edx1Xv") }

    it "Entao recebo a confirmacao com sucesso" do
      @header = { "Content-Type" => "application/json", "UserName" => "Yj3b0CsopkBR",
                  "RequestOrigin" => "5", "Authorization" => "bearer #{@token.parsed_response["access_token"]}" }

      @body = {
        "Data": { "CodigoCanal": 47, "CodigoCliente": 7309, "StatusCartao": "Todos" },
      }.to_json

      @card = Consultar.post("/Transacoes/ConsultarCartoes", body: @body, headers: @header)
      expect(@card.response.code).to eql "200"
      expect(@card.parsed_response["Message"]).to eql "Success"
      expect(@card.parsed_response["ResultCode"]).to eql 0
    end

    it "Entao recebo código canal não encontrado" do
      @header = { "Content-Type" => "application/json", "UserName" => "Yj3b0CsopkBR",
                  "RequestOrigin" => "5", "Authorization" => "bearer #{@token.parsed_response["access_token"]}" }

      @body = {
        "Data": { "CodigoCanal": 44, "CodigoCliente": 7309, "StatusCartao": "Todos" },
      }.to_json
      @card = Consultar.post("/Transacoes/ConsultarCartoes", body: @body, headers: @header)
      expect(@card.response.code).to eql "200"
      expect(@card.parsed_response["Message"]).to eql "Usuário não encontrado."
      expect(@card.parsed_response["ResultCode"]).to eql 6
    end

    it "Entao recebo código cliente não encontrado" do
      @header = { "Content-Type" => "application/json", "UserName" => "Yj3b0CsopkBR",
                  "RequestOrigin" => "5", "Authorization" => "bearer #{@token.parsed_response["access_token"]}" }
      @body = {
        "Data": { "CodigoCanal": 47, "CodigoCliente": 7308, "StatusCartao": "Todos" },
      }.to_json
      @card = Consultar.post("/Transacoes/ConsultarCartoes", body: @body, headers: @header)
      expect(@card.response.code).to eql "200"
      expect(@card.parsed_response["Message"]).to eql "Usuário não encontrado."
      expect(@card.parsed_response["ResultCode"]).to eql 6
    end
  end
end
