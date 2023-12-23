class Api::V1::BaseController < ActionController::API
  before_action :log_user
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def log_user
    Rails.logger.info "Authorization Header: #{request.headers['Authorization']}"
    Rails.logger.info "Current User: #{current_user.inspect}" if defined?(current_user)
  end
end
