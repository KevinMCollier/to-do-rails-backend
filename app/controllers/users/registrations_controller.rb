module Users
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json

    def create
      build_resource(sign_up_params)

      resource.save
      if resource.persisted?
        if resource.active_for_authentication?
          render json: resource, status: :created
        else
          render json: { message: "Signed up but inactive." }, status: :unprocessable_entity
        end
      else
        render json: resource.errors, status: :unprocessable_entity
      end
    end
  end
end
