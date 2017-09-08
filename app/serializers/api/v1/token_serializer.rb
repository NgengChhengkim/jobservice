class Api::V1::TokenSerializer < ApiSerializer
  attributes :token, :refresh_token, :expires_in, :created_at
  attribute :expires_on

  def expires_on
    Time.zone.at object.created_at + object.expires_in if object.created_at
  end
end
