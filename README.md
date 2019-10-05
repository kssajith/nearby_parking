# NearbyParking

An HTTP API only application to get the closest car parks with the lot availability.

## Assumptions

1. Carpark information is dowanloaded from [here](https://data.gov.sg/dataset/hdb-carpark-information?resource_id=139a3035-e624-4f56-b63f-89ae28d4ae4c).
   Data will be loaded to the database assuming that 'Car Park No.' will hold the unique identifier for the carpark.

2. Carpark availability API specification can be read [here](https://data.gov.sg/dataset/carpark-availability)
   Carpark slot availability from this API has been updated assuming that values in `carpark_number` field in api response is exactly same as the `car_park_no` in carpark information api mentioned above.

## Installation and Setup

### Dependencies

- Ruby version - ruby-2.5.3
- MySQL - 8.0.17

### Configuration

Clone the application code and create `database.yml` in config directory and add the credentials accordingly as per the template file `database.yml.example`

### Install dependencies

Navigae to the application root and run: `bundle install`

### Database creation

Navigae to the application root and run:

1. `bundle exec rake db:create`

2. `bundle exec rake db:migrate`

### How to run the test suite

Navigae to the application root and run:

`bundle exec rspec` (`bundle exec rspec --format documentation` for detailed information)

### Load carparking info

Navigae to the application root and run:
`bundle exec rake data_loader:load_carpark_info`

### To start the application

Navigae to the application root and run:

`bundle exec rails server`

to start the application in development mode

## Sample request and response

- Success response:

```bash
$ curl "http://localhost:3000/carparks/nearest?latitude=1.365260&longitude=103.845115&page=1&per_page=1"

[{"address":"BLK 308C ANG MO KIO AVE 1","latitude":"1.36554","longitude":"103.844619","total_lots":454,"lots_available":152}]
```

- Error response (paramater `longitude` is not passed):

```bash
$ curl "http://localhost:3000/carparks/nearest?latitude=1.365260&page=1&per_page=1"

{"errors":[{"title":"Mandatory params missing","status":400,"details":"Request should have valid latitude, longitude params"}]}
```
