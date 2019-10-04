require_relative '../http_client'
require_relative '../date_time_helper'

module DataLoader
  class CarParkAvailabilityUpdater
    include DateTimeHelper

    attr_reader :http_client, :logger

    def initialize(logger, http_client = HttpClient.new)
      @http_client = http_client
      @logger = logger
    end

    def run
      singapore_time = current_time_sgt.strftime('%Y-%m-%dT%H:%M:%S')
      api_url = base_url % { date_time: singapore_time }
      logger.info api_url

      begin
        response = JSON.parse(http_client.get(api_url))
      rescue Timeout::Error, Errno::ECONNRESET, SocketError => e
        logger.error "Error fetching the API. Quitting! #{e.message}"
        return
      rescue JSON::ParserError => e
        logger.error "Error parsing the response. Quitting!"
        return
      end

      { number_of_records_updated: process_and_update(response) }
    end

    private

    def base_url
      # "https://api.data.gov.sg/v1/transport/carpark-availability?date_time=2019-10-04T18%3A30%3A00"
      "https://api.data.gov.sg/v1/transport/carpark-availability?date_time=%{date_time}"
    end

    def process_and_update(response)

      counter = 0
      response['items'].first['carpark_data'].each do |record|
        # {
        #   "carpark_info"=>[{"total_lots"=>"91", "lot_type"=>"C", "lots_available"=>"13"}],
        #   "carpark_number"=>"HE12",
        #   "update_datetime"=>"2019-10-03T14:57:34"
        # }
        parking_lot = Carpark.find_by_car_park_no(record['carpark_number'])
        next unless parking_lot

        attributes = {
          total_lots: record['carpark_info'].first['total_lots'],
          lots_available: record['carpark_info'].first['lots_available'],
          availability_updated_at: sgt_to_utc(record['update_datetime'])
        }
        counter += 1 if parking_lot.update(attributes)
      end

      counter
    end
  end
end
