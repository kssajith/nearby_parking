FactoryBot.define do
  factory :carpark do
    car_park_no { 'ABC' }
    total_lots { 10 }
    lots_available { 5 }
  end
end
