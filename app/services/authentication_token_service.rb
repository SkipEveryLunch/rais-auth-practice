class AuthenticationTokenService
    HMAC_SEACRET = "seacret"
    ALGORITHM = "HS256"
    def self.call(user_id)
        payload = {user_id: user_id}
        JWT.encode payload, HMAC_SEACRET, ALGORITHM
    end
    def self.decode(token)
        decoded = JWT.decode(
            token, 
            HMAC_SEACRET, 
            true,
            {algorithm:ALGORITHM} 
          ) 
    end
end 