class Api::V1::AuthorizationController < ApplicationController
  include LoginDoc
  include RefreshTokenDoc
end
