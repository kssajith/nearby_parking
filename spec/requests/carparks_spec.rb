require 'rails_helper'

describe 'Carparks', type: :request do
  describe '/carparks/nearest' do
    before do
      create(:carpark, car_park_no: 'NUM1', latitude: 1.36554, longitude: 103.844619, address: 'NUM1' )
      create(:carpark, car_park_no: 'NUM2', latitude: 4.36554, longitude: 10.844619, address: 'NUM2' )
    end

    it 'returns json response' do
      get "/carparks/nearest?latitude=1.365260&longitude=103.845115&page=1&per_page=4"

      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it 'returns array of nearby carpark lots as per limit and offset' do
      get "/carparks/nearest?latitude=1.365260&longitude=103.845115&page=1&per_page=1"
      expect(response.body).to eq("[{\"address\":\"NUM1\",\"latitude\":\"1.36554\",\"longitude\":\"103.844619\",\"total_lots\":10,\"lots_available\":5}]")
    end

    it 'return error if any or both of latitude and longitude param missing' do
      get "/carparks/nearest?latitude=1.365260&page=1&per_page=1"
      expect(response.body).to eq('{"errors":[{"title":"Mandatory params missing","status":400,"details":"Request should have valid latitude, longitude params"}]}')
    end
  end
end
