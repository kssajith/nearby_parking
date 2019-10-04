require_relative '../data_loader/car_park_info_loader'
require_relative '../data_loader/car_park_availability_updater'
require 'logger'
logger = Logger.new(STDOUT)

namespace :data_loader do
  desc 'Task to load car park information'
  task load_carpark_info: :environment do
    logger.info "Start loading carpark information"

    data_file_path = Rails.root.join('data/hdb-carpark-information.csv')
    data_loader = DataLoader::CarParkInfoLoader.new(logger)
    result = data_loader.load_data(data_file_path)

    logger.info "Carpark information loaded. Result: #{result}"
  end

  desc 'Task to update the availability of exosting carparks'
  task update_carpark_availability: :environment do
    logger.info 'Start task to update carpark availability'
    result = DataLoader::CarParkAvailabilityUpdater.new(logger).run
    logger.info "Completed task to update carpark availability. Result: #{result}"
  end
end
