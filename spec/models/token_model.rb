class TokenModel
  attr_accessor :grant_type, :username, :password

  def to_hash
    {
      grant_type: @grant_type,
      username: @username,
      password: @password,
    }
  end
end
