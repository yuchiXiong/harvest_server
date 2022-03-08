# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :bills, primary_key: :uuid

  before_create do |u|
    u.uuid = SecureRandom.uuid
  end

  def self.find_by_jwt(token)
    decoded_token = JWT.decode token, 'xxxxx', true, { algorithm: 'HS256' }
    decoded_token[0]['uuid']
  end

  def jwt
    payload = {
      exp: Time.current.to_i + 7 * 24 * 60 * 60 * 1000,
      uuid:
    }
    JWT.encode payload, 'xxxxx', 'HS256'
  end
end
