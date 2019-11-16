class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  def render_json_error(status, error_code, extra = {})
    status = Rack::Utils::SYMBOL_TO_STATUS_CODE[status] if status.is_a? Symbol
    error = {
      title: error_code,
      status: status,
    }.merge(extra)

    render json: { errors: [error] }, status: status
  end

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not authorized' }, status: 401 unless @current_user
  end
end
