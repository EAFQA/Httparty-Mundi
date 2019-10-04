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

  context "include card" do
    before { token("password", "Yj3b0CsopkBR", "umo1LNtje0Edx1Xv") }

    it "success" do
      @header =
        {
          "Content-Type" => "application/json",
          "UserName" => "Yj3b0CsopkBR",
          "RequestOrigin" => "5",
          "Authorization" => "bearer " + @token.parsed_response["access_token"],
        }

      puts @header

      @body =
        {
          "Data": {
            "CodigoCanal": 47,
            "CodigoCliente": 7309,
            "Apelido": "Teste",
            "NomeImpresso": "Eduardo Teste",
            "NumeroCartao": "5487239429786598",
            "DataValidade": "202109",
            "CodigoSeguranca": "501",
            "ValidarCartao": "false",
          },
        }.to_json

      puts @body
      @card = Cadastrar.post("/Transacoes/IncluirCartao", body: @body, headers: @header)
      puts @card.body
    end
  end
end
