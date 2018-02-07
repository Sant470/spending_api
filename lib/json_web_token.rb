class JsonWebToken
  def self.encode(payload)
    JWT.encode(payload, 'asdf1234')
  end

  def self.decode(token)
    return HashWithIndifferentAccess.new(JWT.decode(token, 'asdf1234', false)[0])
  rescue StandardError => e
    nil
  end
end
