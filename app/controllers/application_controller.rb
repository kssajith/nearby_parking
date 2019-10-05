class ApplicationController < ActionController::API
  def render_json_error(status, error_code, extra = {})
    status = Rack::Utils::SYMBOL_TO_STATUS_CODE[status] if status.is_a? Symbol
    error = {
      title: error_code,
      status: status,
    }.merge(extra)

    render json: { errors: [error] }, status: status
  end
end
