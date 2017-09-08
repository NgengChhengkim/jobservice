class Api::V1::LoginSerializer < ApiSerializer
  attributes :user, :access_token

  def user
    Api::V1::UserSerializer.new object
  end

  def access_token
    Api::V1::TokenSerializer.new instance_options[:access_token]
  end
end
