require 'rails_helper'

RSpec.describe Carpark, type: :model do
  it 'vlidates uniqueness of car_park_no' do
    create(:carpark, car_park_no: 'NUM')
    expect(build(:carpark, car_park_no: 'NUM')).not_to be_valid
  end
end
