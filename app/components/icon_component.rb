# frozen_string_literal: true

class IconComponent < ViewComponent::Base
  ICON_FAMILY = 'solid'

  attr_reader :name, :options

  def initialize(name:, **options)
    @name = name
    @options = options

    verify_icon_svg_exists!
  end

  def icon_svg_path
    "icons/#{ICON_FAMILY}/#{name}.svg"
  end

  private

  def verify_icon_svg_exists!
    return if File.exist?(Rails.root.join('app', 'assets', 'images', icon_svg_path))

    fail "Missing icon #{name}"
  end
end
