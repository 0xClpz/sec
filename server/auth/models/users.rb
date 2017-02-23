require 'digest'

DB.create_table? :users do
  uuid :uuid, primary_key: true
  String :email, null: false, unique: true
  String :password_digest
  DateTime :last_login
  Integer :password_failure_number, null: false, default: 0
  DateTime :password_failure_time
  DateTime :created_at, null: false
  DateTime :updated_at, null: false
end

class User < Sequel::Model
  plugin :secure_password

  def jwt_subject
    uuid
  end

  def before_create
    self.updated_at = Time.now
    self.created_at = self.updated_at
    super
  end

  def before_update
    self.updated_at = Time.now
    super
  end
end
