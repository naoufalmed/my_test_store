require 'spec_helper'

module Spree
  describe Api::UsersController do

      render_views

      let(:valid_user) { create(:user, email: "valid@user.com", password:"secret") }
      let(:attributes) { [:id, :email, :created_at, :updated_at] }

      context "as a valid user" do

        it "can log in" do

          api_post :login, { email: valid_user.email, password: valid_user.password }, format: :json

          expect(response.status).to eq 200

        end      
      end

    end
end
