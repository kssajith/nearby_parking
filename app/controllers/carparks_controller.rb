class CarparksController < ApplicationController
  def nearest
    nearest_carparks = Carpark.
      with_available_lot.
      by_distance(:origin => [params[:latitude], params[:longitude]]).
      page(params[:page]).
      per(params[:per_page])

    render json: nearest_carparks.as_json(only: fields_required)
  end

  private

  def fields_required
    [:address, :latitude, :longitude, :total_lots, :lots_available]
  end

end
