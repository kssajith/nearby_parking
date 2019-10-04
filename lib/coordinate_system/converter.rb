require_relative '../http_client'

module CoordinateSystem
  class Converter
    attr_reader :http_client

    def initialize(http_client = HttpClient.new)
      @http_client = http_client
    end

    def svy21_to_wgs84(x_coordinate, y_coordinate)
      api_url = svy21_to_wgs84_converter_api(x_coordinate, y_coordinate)

      response = begin
        http_client.get(api_url)
      rescue Timeout::Error, Errno::ECONNRESET, SocketError => e
        raise CoordinateSystem::ConversionError
      end

      response = JSON.parse(response)
      { 'latitude' => response['latitude'], 'longitude' => response['longitude']}
    end

    private

    def svy21_to_wgs84_converter_api(x_coordinate, y_coordinate)
      base_url = "https://developers.onemap.sg/commonapi/convert/3414to4326?X=%{x_coordinate}&Y=%{y_coordinate}"
      params = { x_coordinate: x_coordinate, y_coordinate: y_coordinate }
      base_url % params
    end
  end

  class ConversionError < StandardError
  end
end
