# logic encode & decode cho JWT tokens
class JsonWebToken
  def self.encode(payload, exp = 24.hours.from_now)
    payload['exp'] = exp.to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base, 'HS256')
  end

  def self.decode(token)
    return HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')[0])
  rescue JWT::ExpiredSignature, JWT::VerificationError => e
    puts e.message
    nil
  end
end
