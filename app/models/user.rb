class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  DOORKEEPER_SIGN_IN_PARAMS = [:grant_type, :email, :password]
  DOORKEEPER_REFRESH_TOKEN_PARAMS = [:grant_type, :refresh_token]

  class << self
    def authenticate email, password
      user = User.find_for_database_authentication email: email
      raise APIError::SignIn::InvalidInfo.new if user.nil?
      user if user.authentication_valid?(password)
    end
  end

  def authentication_valid? password
    case
    when wrong_password?(password)
      raise APIError::SignIn::InvalidInfo.new
    when !confirmed_email?
      raise APIError::SignIn::NoneActivate.new
    else
      true
    end
  end

  private
  def wrong_password? password
    !valid_for_authentication? {valid_password? password}
  end

  def confirmed_email?
    confirmed_at.present?
  end
end
