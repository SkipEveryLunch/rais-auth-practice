require 'rails_helper'

RSpec.describe "Authenticate", type: :request do
    let(:user){FactoryBot.create(:user)}
    describe "POST /authenticate" do
        it "authenticate the client" do
            post "/authenticate", params: {name:user.name,password:user.password}
            expect(response).to have_http_status(:created)
            expect(JSON.parse(response.body)).to eq({
                'token'=>"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ._aSVNXkHE-szkpFhVrEbM03P5oBvs1lOm_OQZmxk7Qo"
            })
        end
        it "returns error without name" do
            post "/authenticate", params: {password:user.password}
            expect(response).to have_http_status(:unprocessable_entity)
            expect(JSON.parse(response.body)).to eq({
                "error" => "param is missing or the value is empty: name"
            })
        end
        it "returns error without password" do
            post "/authenticate", params: {name:user.name}
            expect(response).to have_http_status(:unprocessable_entity)
            expect(JSON.parse(response.body)).to eq({
                "error" => "param is missing or the value is empty: password"
            })
        end
        it "returns error with improper password" do
            post "/authenticate", params: {name:user.name, password:'wrong'}
            expect(response).to have_http_status(:unauthorized)
        end
    end
end