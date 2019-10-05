class CarparksController < ApplicationController
  def nearest
    if mandatory_params_missing(params)
      extra = { details: 'Request should have valid latitude, longitude params'}
      render_json_error(:bad_request, 'Mandatory params missing', extra)
      return
    end

    render json: Carpark.nearest_available(params)
  end

  private

  def mandatory_params_missing(params)
    params[:latitude].blank? || params[:longitude].blank?
  end
end
