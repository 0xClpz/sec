module Sec
  class API < Grape::API
    prefix :api
    format :json
    formatter :json, Grape::Formatter::Roar
    rescue_from Sequel::Error

    use Warden::JWTAuth::Middleware

    use Warden::Manager do |manager|
      manager.default_strategies :jwt
      manager.failure_app = lambda do |env|
        content = {error: 'Not authorized'}
        warden_message = env['warden.options'][:message]
        content[:message] = warden_message if warden_message
        [
          401,
          {'Content-Type' => 'application/json'},
          [content.to_json]
        ]
      end
    end

    helpers WardenHelpers

    mount ::Auth::API
    mount ::Sec::Entities::Muscles
    mount ::Sec::Entities::Exercises
    mount ::Sec::Entities::WorkoutSets
  end
end
