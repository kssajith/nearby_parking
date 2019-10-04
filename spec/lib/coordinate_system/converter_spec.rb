require 'rails_helper'
require Rails.root.join('lib/coordinate_system/converter')

describe CoordinateSystem::Converter do
  describe '#svy21_to_wgs84(x_coordinate, y_coordinate)' do
    before do
      allow(subject).to receive(:svy21_to_wgs84_converter_api) { 'svy21_to_wgs84_converter_api' }
      allow_any_instance_of(HttpClient).to receive(:get) do
        {'latitude' => 'converted lat', 'longitude' => 'converted long' }.to_json
      end
    end

    it 'returns result with latitude and longitude' do
      expect(subject.svy21_to_wgs84(1.00, 1.00).keys).
        to eq(['latitude', 'longitude'])
    end
  end
end
