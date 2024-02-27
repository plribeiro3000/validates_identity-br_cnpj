# frozen_string_literal: true

require 'validates_identity'
require_relative 'br_cnpj/version'

class ValidatesIdentity
  module BrCnpj
    autoload :Validator, 'validates_identity/br_cnpj/validator'
  end
end

ValidatesIdentity.register_legal_identity_type('BR_CNPJ', ValidatesIdentity::BrCnpj::Validator)
ValidatesIdentity::ShouldaMatchers.register_legal_allowed_values('BR_CNPJ', %w[51.114.450/0001-46 89905757000138])
ValidatesIdentity::ShouldaMatchers.register_legal_disallowed_values('BR_CNPJ', %w[123456 51.114.450/0001-56])
