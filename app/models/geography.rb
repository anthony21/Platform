# frozen_string_literal: true

class Geography
  include NestedModel
  include Values

  FIELDS = {
    'states' => 'State',
    'counties' => 'County',
    'zip_codes' => 'Zip code',
    'zip_code_radius' => 'Zip code radius',
    'msa' => 'MSA',
    'scf' => 'SCF',
    'cities' => 'City'
  }.freeze

  attribute :states, StringSet.new, default: -> { Set.new }
  attribute :counties, StringSet.new, default: -> { Set.new }
  attribute :zip_codes, StringSet.new, default: -> { Set.new }
  attribute :zip_code, :string
  attribute :zip_code_radius, :integer
  attribute :msa, StringSet.new, default: -> { Set.new }
  attribute :scf, StringSet.new, default: -> { Set.new }
  attribute :cities, StringSet.new, default: -> { Set.new }

  validate :zip_code_radius_is_valid

  delegate :inspect, to: :attributes

  def nationwide?
    [
      states,
      counties,
      zip_codes,
      zip_code,
      msa,
      scf,
      cities
    ].all?(&:blank?)
  end

  private

  def zip_code_radius_is_valid
    return if zip_code.present? && zip_code_radius.present?
    return if zip_code.blank? && zip_code_radius.blank?

    errors.add(:zip_code, 'must include both zip code and radius')
  end
end
