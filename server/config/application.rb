require_relative 'boot'

ENV['RACK_ENV'] ||= 'test'

Bundler.require :default, ENV['RACK_ENV']

# Force flushing STDOUT to make sure we see logs in due time.
$stdout.sync = true if ENV['RACK_ENV'] == 'development'

DB = (ENV['RACK_ENV'] == 'production') ? Sequel.sqlite('/db/sec.db') : Sequel.sqlite
Sequel::Model.plugin :uuid
DB.loggers << Logger.new(STDOUT) if ENV['RACK_ENV'] == 'development'

require 'roar/json'

# Load all models
require_relative File.join('..', 'auth', 'models', 'users')
require_relative File.join('..', 'models', 'exercises')
require_relative File.join('..', 'models', 'workout_sets')

require_relative '../api/helpers/warden_helpers'
require_relative '../api/helpers/crud_helpers'
require_relative '../api/helpers/crud_extension'

# Load all entities API
Dir['api/entities/*.rb'].each do |f|
  require_relative File.join('..', f)
end

require_relative '../auth/warden/strategy/password'
require_relative '../auth/warden/jwt'
require_relative '../auth/api/api'

require_relative '../api/api'

require_relative 'development' if ENV['RACK_ENV'] == 'development'
