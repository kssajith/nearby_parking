require 'rails_helper'
require Rails.root.join('lib/data_loader/car_park_availability_updater')

describe DataLoader::CarParkAvailabilityUpdater do
  subject do
    sample_response = "{\"items\":[{\"timestamp\":\"2019-10-03T" +
    "14:59:27+08:00\",\"carpark_data\":[{\"carpark_info\":[{\"t" +
    "otal_lots\":\"91\",\"lot_type\":\"C\",\"lots_available\":\"1" +
    "3\"}],\"carpark_number\":\"HE12\",\"update_datetime\":\"2019" +
    "-10-03T14:57:34\"}]}]}"

    logger = double('Logger', info: 'logger', error: 'logger')
    http_client = double('HttpClient', get: sample_response)
    DataLoader::CarParkAvailabilityUpdater.new(logger, http_client)
  end

  describe '#run' do
    before do
      create(:parking_lot, car_park_no: 'HE12')
    end

    it 'returns number of records updated' do
      expect(subject.run[:number_of_records_updated]).to eq(1)
    end

    it 'updates the lots available with the data in the api response' do
      subject.run
      expect(ParkingLot.find_by_car_park_no('HE12').lots_available).to eq(13)
    end

    it 'updates total lots with the value in the api response' do
      subject.run
      expect(ParkingLot.find_by_car_park_no('HE12').total_lots).to eq(91)
    end

    it 'updates UTC time in availability_updated_at' do
      subject.run
      time_in_db = ParkingLot.find_by_car_park_no('HE12').availability_updated_at
      expect(time_in_db.strftime('%Y-%m-%dT%H:%M:%S')).to eq('2019-10-03T06:57:34')
    end
  end
end
