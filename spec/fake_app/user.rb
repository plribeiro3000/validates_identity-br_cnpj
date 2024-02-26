# frozen_string_literal: true

class User
  include ActiveModel::Model

  attr_accessor :identity, :identity_type, :formatted_identity, :name

  validates :identity, identity: { identity_type: :identity_type }
  validates :formatted_identity, identity: { identity_type: :identity_type, format: true }
end
