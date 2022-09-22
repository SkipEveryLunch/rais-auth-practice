class AuthenticationController < ApplicationController
    class AuthenticationError < StandardError; end
rescue_from ActionController::ParameterMissing, with: :param_missing
rescue_from AuthenticationError, with: :handle_unauthenticated
    def create
        params.require(:password)
        raise AuthenticationError unless user.authenticate(params.require(:password))
        token = AuthenticationTokenService.call(user.id)
        render json: {'token'=>token}, status: :created
    end
    private
    def user
        @user ||= User.find_by(name: params.require(:name))
    end
    def param_missing(e)
        render json: {'error'=>e.message},status: :unprocessable_entity
    end
    def handle_unauthenticated(e)
        render json: {'error'=>e.message},status: :unauthorized
    end
end
