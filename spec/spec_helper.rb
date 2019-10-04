require "httparty"
require "httparty/request"
require "httparty/response/headers"

require_relative "../services/token_service.rb"
require_relative "../services/newCard_service.rb"
require_relative "../services/consultallcards_service.rb"
require_relative "../services/generatebullet_service.rb"

RSpec.configure do |config|
  include Token
  include Cadastrar
  include Consultar
  include GerarBoleto

  config.color = true
  config.formatter = :documentation

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
