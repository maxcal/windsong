# Manages OmniAuth authentications
class Users::AuthenticationsController < ApplicationController

  # Revokes an authentication from user
  # @note this also attempts to revoke the authentication
  # @example
  #   DELETE /users/:user_id/authentications/:id
  def destroy
    @user = User.find(params[:user_id])
    auth = @authentication = @user.authentications.find(params[:id])
    # raise an exception if the user is not able to perform the given action
    authorize!(:delete, auth)
    case(@authentication.provider)
      when 'facebook'
        api_response =  Net::HTTP.new("graph.facebook.com")
                                .delete("/#{auth.uid}/users/#{auth.token}")
        unless api_response.body === 'TRUE'
          Rails.logger.error("Attempted to revoke app permissions for #{@user.id}, " +
                                 "but received a negative response from Facebook.")
        end
    end
    @authentication.destroy!
    sign_out @user
    redirect_to root_path, notice: I18n.t('flashes.authentication.deleted', provider: @authentication.provider.capitalize)
  end
end