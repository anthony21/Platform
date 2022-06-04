# frozen_string_literal: true

class ZipCode < ApplicationRecord
  def self.within_radius(zip_code, mile_radius)
    return [] if zip_code.blank? || mile_radius.blank?

    meter_radius = mile_radius * 1609.34

    joins(
      <<-SQL
      INNER JOIN zip_codes zip_codes_2 ON (
        ST_DISTANCE_SPHERE(
          POINT(zip_codes.longitude, zip_codes.latitude),
          POINT(zip_codes_2.longitude, zip_codes_2.latitude)
        ) < #{meter_radius}
      )
      SQL
    ).where(zip_code:).pluck('zip_codes_2.zip_code')
  end
end
