class UserRepo
  def self.find_for_jwt_authentication(_sub)
    User.with_pk(_sub)
  end
end

class RevocationStrategy
  def self.jwt_revoked?(payload, user)
    false
  end
end

Warden::JWTAuth.configure do |config|
  config.secret = 'super-secret'
  config.expiration_time = 31 * 24 * 60 * 60
  config.mappings = {default: UserRepo}
  config.dispatch_requests = [['POST', %r{^/api/login$}]]
  config.revocation_strategies = {default: RevocationStrategy}
end
