module Spree
  module Api
    UsersController.class_eval do


    skip_before_filter :authenticate_user, only: [:login]
    skip_before_filter :check_for_user_or_api_key, only: [:login]

      def login
        
        @user = User.find_for_database_authentication(:email => params[:email])
        return invalid_login_attempt unless @user

        if @user.valid_password?(params[:password])

          @user.ensure_authentication_token! 
          respond_with(@user, status: :ok)
          return

        else
          render "spree/api/errors/unauthorized", :success => false, :status => :unauthorized and return
        end
      end

    end
  end
end