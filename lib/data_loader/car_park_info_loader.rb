require_relative '../coordinate_system/converter'

module DataLoader
  class CarParkInfoLoader
    attr_reader :coordinate_converter, :logger

    def initialize(logger, coordinate_converter = CoordinateSystem::Converter.new)
      @logger = logger
      @coordinate_converter = coordinate_converter
    end

    def load_data(data_file_path)
      file = File.open(data_file_path, 'r')
      header_line = file.first
      headings = split_and_clean(header_line, delimiter)
      updated_count = 0
      error_count = 0

      file.each_line do |line|
        info_record = begin
          process_line(line, headings)
        rescue CoordinateSystem::ConversionError => e
          logger.error "Coordinate system converson error, skipping entry : #{entry}"
          error_count += 1
          next
        end

        unless update_to_database(info_record)
          logger.error "Error updating record to database"
          error_count += 1
          next
        end

        updated_count += 1
      end

      {
        total_records: no_of_lines(data_file_path),
        updated_count: updated_count,
        error_count: error_count
      }
    end

    def process_line(line, headings)
      entry = split_and_clean(line, delimiter)
      info_record = create_info_record(entry, headings)
      logger.info "Record : #{info_record}"
      info_record
    end

    private

    def no_of_lines(file_path)
      %x(wc -l "#{file_path}").split[0].to_i
    end

    def delimiter
      '","'
    end

    def split_and_clean(line, delimiter)
      line.split(delimiter).map { |val| val.gsub('"', '').strip }
    end

    def create_info_record(entry, headings)
      record = headings.zip(entry).to_h
      record = change_enum_fields(record)
      record = convert_coordinates(record)

      record
    end

    def change_enum_fields(record)
      enum_fields = %w(car_park_type
        type_of_parking_system
        night_parking
        car_park_basement)

      enum_fields.each do |field|
        record[field] = enum_val(field, record[field].upcase)
      end

      record
    end

    def convert_coordinates(record)
      x_coord = record.delete('x_coord')
      y_coord = record.delete('y_coord')

      converted = coordinate_converter.svy21_to_wgs84(x_coord, y_coord)
      record['latitude'] = converted['latitude']
      record['longitude'] = converted['longitude']

      record
    end

    def enum_val(field, val)
      ParkingLot.send(field.pluralize)[val]
    end

    def update_to_database(info_record)
      record = ParkingLot.where(car_park_no: info_record['car_park_no']).
        first_or_create!

      record.update(info_record.except('car_park_no'))
    end
  end
end
