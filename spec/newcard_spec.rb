describe "post" do
  def token(grant_type, username, password)
    @body = build(:new_token).to_hash
    @token = Token.post("/token", body: @body)
  end

  context "Quando insiro um novo cartao" do
    before { token("password", "Yj3b0CsopkBR", "umo1LNtje0Edx1Xv") }

    it "Entao recebo a confirmacao com sucesso" do
      @header = { "Content-Type" => "application/json", "UserName" => "Yj3b0CsopkBR",
                 "RequestOrigin" => "5", "Authorization" => "bearer " + @token.parsed_response["access_token"] }
      @body = {
        "Data": { "CodigoCanal": 47, "CodigoCliente": 7309, "Apelido": "Testendo1234", "NomeImpresso": "Testando1234",
                  "NumeroCartao": "5533006298137243", "DataValidade": "202109", "CodigoSeguranca": "501",
                  "ValidarCartao": "false" },
      }.to_json
      @card = Cadastrar.post("/Transacoes/IncluirCartao", body: @body, headers: @header)
      expect(@card.response.code).to eql "200"
      expect(@card.parsed_response["ResultCode"]).to eql 0
      expect(@card.parsed_response["Message"]).to eql "Success"
    end

    it "Numero do cartao ja utilizado" do
      @header = { "Content-Type" => "application/json", "UserName" => "Yj3b0CsopkBR",
                 "RequestOrigin" => "5", "Authorization" => "bearer " + @token.parsed_response["access_token"] }
      @body = {
        "Data": { "CodigoCanal": 47, "CodigoCliente": 7309, "Apelido": "Teste96", "NomeImpresso": "Eduardo Teste96",
                  "NumeroCartao": "5355681127695150", "DataValidade": "202109", "CodigoSeguranca": "501",
                  "ValidarCartao": "false" },
      }.to_json
      @card = Cadastrar.post("/Transacoes/IncluirCartao", body: @body, headers: @header)
      expect(@card.response.code).to eql "200"
      expect(@card.parsed_response["ResultCode"]).to eql 6
      expect(@card.parsed_response["Message"]).to eql "Número do cartão já utilizado."
    end

    it "Apelido ja utilizado" do
      @header = { "Content-Type" => "application/json", "UserName" => "Yj3b0CsopkBR",
                 "RequestOrigin" => "5", "Authorization" => "bearer " + @token.parsed_response["access_token"] }
      @body = {
        "Data": { "CodigoCanal": 47, "CodigoCliente": 7309, "Apelido": "Teste98", "NomeImpresso": "Eduardo Teste98",
                  "NumeroCartao": "5586357744881322", "DataValidade": "202109", "CodigoSeguranca": "501",
                  "ValidarCartao": "false" },
      }.to_json
      @card = Cadastrar.post("/Transacoes/IncluirCartao", body: @body, headers: @header)
      expect(@card.response.code).to eql "200"
      expect(@card.parsed_response["ResultCode"]).to eql 5
      expect(@card.parsed_response["Message"]).to eql "Apelido do cartão já utilizado."
    end
  end
end
