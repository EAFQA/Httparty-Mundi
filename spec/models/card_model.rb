class CardModel
  attr_accessor :CodigoCanal, :CodigoCliente, :Apelido, :NomeImpresso,
                :NumeroCartao, :DataValidade, :CodigoSeguranca, :ValidarCartao

  def to_hash
    {
      CodigoCanal: @CodigoCanal,
      CodigoCliente: @CodigoCliente,
      Apelido: @Apelido,
      NomeImpresso: @NomeImpresso,
      NumeroCartao: @NumeroCartao,
      DataValidade: @DataValidade,
      CodigoSeguranca: @CodigoSeguranca,
      ValidarCartao: @ValidarCartao,
    }
  end
end
