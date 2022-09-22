require 'rails_helper'

RSpec.describe AuthenticationTokenService do
  describe ".call" do
    let(:token){described_class.call(1)}
    it "returns authentication token" do
        decoded = JWT.decode(
          token, 
          described_class::HMAC_SEACRET, 
          true,
          {algorithm:described_class::ALGORITHM} 
        ) 
        expect(decoded[0]).to eq({"user_id"=>1})
    end
  end
end