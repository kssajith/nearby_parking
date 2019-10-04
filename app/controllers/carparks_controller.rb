class CarparksController < ApplicationController
  def nearest
    nearest_carparks = Carpark.nearest(params)
    render json: nearest_carparks
  end
end
