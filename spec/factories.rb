require_relative "models/token_model"
require_relative "models/card_model"

FactoryBot.define do
  factory :new_token, class: TokenModel do
    grant_type { "password" }
    username { "Yj3b0CsopkBR" }
    password { "umo1LNtje0Edx1Xv" }
  end

  factory :username_invalid, class: TokenModel do
    grant_type { "password" }
    username { "Y4j3b0CsopkBR" }
    password { "umo1LNtje0Edx1Xv" }
  end

  factory :password_invalid, class: TokenModel do
    grant_type { "password" }
    username { "Yj3b0CsopkBR" }
    password { "1umo1LNtje0Edx1Xv" }
  end

  factory :username_blank, class: TokenModel do
    grant_type { "password" }
    username { " " }
    password { "1umo1LNtje0Edx1Xv" }
  end

  factory :password_blank, class: TokenModel do
    grant_type { "password" }
    username { "Yj3b0CsopkBR" }
    password { " " }
  end

  factory :grant_type_blank, class: TokenModel do
    grant_type { " " }
    username { "Yj3b0CsopkBR" }
    password { "1umo1LNtje0Edx1Xv" }
  end

  factory :new_card, class: CardModel do
    CodigoCanal { 47 }
    CodigoCliente { 7309 }
    Apelido { "Teste96" }
    NomeImpresso { "Eduardo Teste96" }
    NumeroCartao { "5283438702935312" }
    DataValidade { "202109" }
    CodigoSeguranca { "501" }
    ValidarCartao { "false" }
  end
end
