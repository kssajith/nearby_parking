require 'rails_helper'

RSpec.describe Carpark, type: :model do
  it 'vlidates uniqueness of car_park_no' do
    create(:carpark, car_park_no: 'NUM')
    expect(build(:carpark, car_park_no: 'NUM')).not_to be_valid
  end

  describe '.nearest_available(params)' do
    context 'when parameters are valid' do
      let(:params) {
        {
          latitude: 1.365260,
          longitude: 103.845115,
          page: 1,
          per_page: 1
        }
      }

      before do
        create(:carpark, car_park_no: 'NUM1', latitude: 1.36554, longitude: 103.844619, address: 'NUM1' )
        create(:carpark, car_park_no: 'NUM2', latitude: 4.36554, longitude: 10.844619, address: 'NUM2' )
      end

      it 'returns array of nearest available lots' do
        expect(Carpark.nearest_available(params).first['address']).to eq('NUM1')
      end

      it 'returns array of hashes with the specific details' do
        keys = %w(address latitude longitude total_lots lots_available)
        expect(Carpark.nearest_available(params).first.keys).to eq(keys)
      end
    end

    context 'when coordinates are out of range' do
      let(:out_of_range_params) {
        {
          latitude: 91.001,
          longitude: 103.845115,
          page: 1,
          per_page: 1
        }
      }

      it 'returns error message' do
        response = [{ error: 'Coordinate value(s) out of range' }]
        expect(Carpark.nearest_available(out_of_range_params)).to eq(response)
      end
    end
  end

  describe '.coordinates_in_range?(params)' do
    let(:valid_coordinates) { { latitude: 0, longitude: 0 } }
    let(:invalid_coordinates1) { { latitude: 100, longitude: 0 } }
    let(:invalid_coordinates2) { { latitude: 0, longitude: 181 } }
    let(:invalid_coordinates3) { { latitude: 91, longitude: 181 } }

    it 'returns true if -90.0 <= latitude <= 90 and -180 <= longitude <= 180' do
      expect(Carpark.coordinates_in_range?(valid_coordinates)).to be true
    end

    it 'returns false otherwise' do
      expect(Carpark.coordinates_in_range?(invalid_coordinates1)).to be false
      expect(Carpark.coordinates_in_range?(invalid_coordinates2)).to be false
      expect(Carpark.coordinates_in_range?(invalid_coordinates3)).to be false
    end
  end
end
