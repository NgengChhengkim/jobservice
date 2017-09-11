module Api::V1::ExceptionRescue
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalidation_response
    rescue_from APIError::Base, with: :render_api_error_response
    rescue_from ActionController::ParameterMissing, ActiveRecord::RecordNotFound,
      ArgumentError, ActiveRecord::RecordNotDestroyed, with: :render_params_error_response

    def render_invalidation_response exception
      render json: exception.record, serializer: Api::V1::Errors::ValidationErrorsSerializer,
        status: :bad_request
    end

    def render_api_error_response exception
      render json: exception, serializer: Api::V1::Errors::ApiErrorsSerializer,
        status: :bad_request
    end

    def render_params_error_response exception
      render json: exception, serializer: Api::V1::Errors::ParamsErrorsSerializer,
        status: :bad_request
    end
  end
end
