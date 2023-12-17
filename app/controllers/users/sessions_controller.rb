module Users
  class SessionsController < Devise::SessionsController
    respond_to :json

    private

    def respond_with(resource, _opts = {})
      if resource.persisted?
        render json: { user: resource, token: resource.authentication_token }
      else
        render json: { error: 'Invalid email or password'}, status: :unauthorized
      end
    end

    def respond_to_on_destroy
      head :no_content
    end

    # def create
    #   Rails.logger.info "Received params: #{params.inspect}"
    #   super
    # end
  end
end
