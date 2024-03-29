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

  context "Quando cadastro um novo usuário" do
    before { token("password", "Yj3b0CsopkBR", "umo1LNtje0Edx1Xv") }

    it "Entao recebo a confirmacao com sucesso" do
      header = { "Content-Type" => "application/json", "UserName" => "Yj3b0CsopkBR",
                 "RequestOrigin" => "5", "Authorization" => "bearer #{@token.parsed_response["access_token"]}" }
      body = {
        "Data": { "CodigoCanal": 47, "Nome": "Eduardo Andrade", "DataNascimento": "1988-07-11T11:52:26.889Z",
                  "Sexo": "M", "Cpf": "62695258020", "Rg": "16323740", "RgEmissor": "SSP",
                  "RgDataEmissao": "2018-10-15T11:52:26.890Z", "Email": "eduardo.andrade@mundibankikkk.com.br",
                  "Endereco": { "EndeResCep": "06040470", "EndeResLogradouro": "Rua Lazaro Suave", "EndeResNumero": "233",
                                "EndeResComplemento": "", "EndeResEstado": "SP", "EndeResCidade": "Osasco",
                                "EndeResBairro": "City Bussocaba" }, "Senha": "Edu@110788", "DdiCelular": 55,
                  "DddCelular": 11, "NumeroCelular": 886987869, "EnviarEmailPrimAcesso": true },
      }.to_json
      puts @header
      puts @body
      @cadastropf = ContaDigital.post("/ContaDigital/CadastroPf", body: body, headers: header)
      puts @cadastropf
      expect(@cadastropf.response.code).to eql "200"
      expect(@cadastropf.parsed_response["ResultCode"]).to eql 37
      expect(@cadastropf.parsed_response["Message"]).to eql "Protocolo Inválido"
    end

    it "Entao recebo E-mail já cadastrado." do
      header = { "Content-Type" => "application/json", "UserName" => "Yj3b0CsopkBR",
                 "RequestOrigin" => "5", "Authorization" => "bearer #{@token.parsed_response["access_token"]}" }
      body = {
        "Data": { "CodigoCanal": 47, "Nome": "Eduardo Andrade", "DataNascimento": "1988-07-11T11:52:26.889Z",
                  "Sexo": "M", "Cpf": "47153237020", "Rg": "16323740", "RgEmissor": "SSP",
                  "RgDataEmissao": "2018-10-15T11:52:26.890Z", "Email": "eduardo.andrade@mundibankkkk.com.br",
                  "Endereco": { "EndeResCep": "06040470", "EndeResLogradouro": "Rua Lazaro Suave", "EndeResNumero": "233",
                                "EndeResComplemento": "", "EndeResEstado": "SP", "EndeResCidade": "Osasco",
                                "EndeResBairro": "City Bussocaba" }, "Senha": "Edu@110788", "DdiCelular": 55,
                  "DddCelular": 11, "NumeroCelular": 886987809, "EnviarEmailPrimAcesso": true },
      }.to_json
      puts @header
      puts @body
      @cadastropf = ContaDigital.post("/ContaDigital/CadastroPf", body: body, headers: header)
      puts @cadastropf
      expect(@cadastropf.response.code).to eql "200"
      expect(@cadastropf.parsed_response["ResultCode"]).to eql 138
      expect(@cadastropf.parsed_response["Message"]).to eql "E-mail já cadastrado."
    end

    it "Entao recebo CPF/CNPJ já cadastrado" do
      header = { "Content-Type" => "application/json", "UserName" => "Yj3b0CsopkBR",
                 "RequestOrigin" => "5", "Authorization" => "bearer #{@token.parsed_response["access_token"]}" }
      body = {
        "Data": { "CodigoCanal": 47, "Nome": "Eduardo Andrade", "DataNascimento": "1988-07-11T11:52:26.889Z",
                  "Sexo": "M", "Cpf": "18459355004", "Rg": "16323740", "RgEmissor": "SSP",
                  "RgDataEmissao": "2018-10-15T11:52:26.890Z", "Email": "eduardo.andrade@mundibankkk.com.br",
                  "Endereco": { "EndeResCep": "06040470", "EndeResLogradouro": "Rua Lazaro Suave", "EndeResNumero": "233",
                                "EndeResComplemento": "", "EndeResEstado": "SP", "EndeResCidade": "Osasco",
                                "EndeResBairro": "City Bussocaba" }, "Senha": "Edu@110788", "DdiCelular": 55,
                  "DddCelular": 11, "NumeroCelular": 962562620, "EnviarEmailPrimAcesso": true },
      }.to_json
      puts @header
      puts @body
      @cadastropf = ContaDigital.post("/ContaDigital/CadastroPf", body: body, headers: header)
      puts @cadastropf
      expect(@cadastropf.response.code).to eql "200"
      expect(@cadastropf.parsed_response["ResultCode"]).to eql 177
      expect(@cadastropf.parsed_response["Message"]).to eql "CPF/CNPJ já cadastrado."
    end
  end
end
