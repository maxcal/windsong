class Users::AuthenticationsController < ApplicationController

  # /users/:user_id/authentications/:id
  def destroy

    @user = User.find(params[:user_id])
    auth = @authentication = @user.authentications.find(params[:id])

    case(@authentication.provider)
      when 'facebook'
        api_response =  Net::HTTP.new("graph.facebook.com")
                                .delete("/#{auth.uid}/users/#{auth.token}")
        unless api_response.body === 'TRUE'
          Rails.logger.error("Attempted to revoke app permissions for #{auth.user.id}, " +
                                 "but received a negative response from Facebook.")
        end
    end

    @authentication.destroy!
    redirect_to root_path

  end
end