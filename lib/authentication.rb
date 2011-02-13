module Authentication
  def self.authenticate(password)
    BCrypt::Password.new(AppConfig.hashed_password) == password
  end
end
