module Api
  module V1
    class ApplicationController < ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken
      before_action :get_current_user

      def get_current_user
        if request.headers['access-token'].nil? or request.headers['client'].nil? or request.headers['uid'].nil?
          return nil
        end

        current_user = User.find_by(uid: request.headers['uid'])

        if current_user &&
          current_user.tokens.has_key?(request.headers["client"])
          token = current_user.tokens[request.headers["client"]]
          expiration_datetime = DateTime.strptime(token["expiry"].to_s, "%s")

          expiration_datetime > DateTime.now
          @current_user = current_user
        end

        raise @current_user.inspect
      end
    end
  end
end


