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

  context "Quando insiro um novo cartao" do
    before { token("password", "Yj3b0CsopkBR", "umo1LNtje0Edx1Xv") }

    it "Entao recebo a confirmacao com sucesso" do
      @header = { "Content-Type" => "application/json", "UserName" => "Yj3b0CsopkBR",
                 "RequestOrigin" => "5", "Authorization" => "bearer " + @token.parsed_response["access_token"] }
      @body = {
        "Data": { "CodigoCanal": 47, "CodigoCliente": 7309, "DataVencimento": "20191030", "Valor": 999,
                  "Email": "eduardo.andrade@mundibank.com.br",
                  "DadosSacado": { "CpfCnpj": "09551826620", "Nome": "Eduardo Teste", "Endereco": "Rua Teste", "Bairro": "Teste",
                                   "Cidade": "São Pualo", "Cep": "05338000", "Uf": "SP" } },
        "RetornarBase64": "true",
      }.to_json
      puts @header
      puts @body
      @bullet = GerarBoleto.post("/CashIn/GerarBoleto", body: @body, headers: @header)
      puts @bullet
      expect(@bullet.response.code).to eql "200"
      expect(@bullet.parsed_response["ResultCode"]).to eql 0
      expect(@bullet.parsed_response["Message"]).to eql "Sucesso."
    end
  end
end
