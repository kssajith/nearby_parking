# NearbyParking

An HTTP API only application to get the closest car parks with the lot availability.

## Assumptions

1. Carpark informationis doanloaded from [here](https://data.gov.sg/dataset/hdb-carpark-information?resource_id=139a3035-e624-4f56-b63f-89ae28d4ae4c).
   Data will be loaded to the database assuming that 'Car Park No.' will hold the unique identifier for the carpark.

## Installation and Setup

### Dependencies

- Ruby version - ruby-2.5.3
- MySQL - 8.0.17

### Configuration

Create `database.yml` in config directory and add the credentials accordingly as per the template file `database.yml.example`

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

`bundle exec rails s`

to start the application in development mode
