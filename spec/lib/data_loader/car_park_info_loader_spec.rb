require 'rails_helper'
require Rails.root.join('lib/data_loader/car_park_info_loader')
describe DataLoader::CarParkInfoLoader do
  subject do
    logger = double('Logger', info: 'logger', error: 'logger')
    DataLoader::CarParkInfoLoader.new(logger)
  end

  before do
    allow_any_instance_of(CoordinateSystem::Converter).
      to receive(:svy21_to_wgs84) { {latitude: 1.0000, longitude: 1.0000 } }
  end

  describe '#load_data(data_file_path)' do
    let(:file_path) { File.join(File.dirname(__FILE__), '..', '..', 'fixtures', 'car_park_info.csv') }

    context 'when loading car park info file with one new record' do
      it 'add a record to the database' do
        expect {
          subject.load_data(file_path)
        }.to change(Carpark, :count).by(1)
      end

      it 'returns has with total_records, updated_count and error_count' do
        keys = [:total_records, :updated_count, :error_count]
        expect(subject.load_data(file_path).keys).to eq(keys)
      end
    end
  end
end
