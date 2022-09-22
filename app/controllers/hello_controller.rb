class HelloController < ApplicationController
    include ActionController::HttpAuthentication::Token
    before_action :authenticate_user, only: [:hello]
    def hello
        render json: 'hello'
    end
    private
    def authenticate_user
        token, _options = token_and_options(request)
        user_id = AuthenticationTokenService.decode(token)
        puts AuthenticationTokenService.decode(token)[0]["user_id"]
        user = User.find(user_id)
    rescue ActiveRecord::RecordNotFound
        render status: :unauthorized
    end
end