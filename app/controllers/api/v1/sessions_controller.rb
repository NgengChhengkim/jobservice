class Api::V1::SessionsController < Doorkeeper::TokensController
  include ActionController::Rescue
  include ActionController::Serialization
  include ActionController::StrongParameters
  include AbstractController::Callbacks
  include Api::V1::ExceptionRescue

  def create
    params_validation

    ActiveRecord::Base.transaction do
      customize_authorize_response
      update_tracked_fields if params[:grant_type] == "password"
    end

    render json: {
      success: true,
      data: Api::V1::LoginSerializer.new(user, access_token: access_token)
    }
  end

  def revoke
    params_validator User::DOORKEEPER_REVOKE_PARAMS
    raise APIError::SignOut::InvalidToken.new unless can_revoke?

    token.revoke

    render json: {success: true, data: {}}
  end

  private
  def user
    @user ||= case params[:grant_type]
      when "password"
        resource_owner_from_credentials
     when "refresh_token"
        User.find_by_id access_token.resource_owner_id
      end
  end

  def customize_authorize_response
    raise APIError::DoorkeeperToken::InvalidToken.new unless authorize_response.status == :ok
  end

  def access_token
    @access_token ||= authorize_response.token
  end

  def update_tracked_fields
    user.update_tracked_fields! request
  end

  def params_validation
    case params[:grant_type]
    when "password"
      params_validator User::DOORKEEPER_SIGN_IN_PARAMS
    when "refresh_token"
      params_validator User::DOORKEEPER_REFRESH_TOKEN_PARAMS
    else
      raise ArgumentError
    end
  end

  def params_validator require_params
    require_params.each {|param| raise ArgumentError unless params.has_key?(param)}
  end

  def can_revoke?
    authorized? && token.accessible?
  end
end
