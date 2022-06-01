# frozen_string_literal: true

class ButtonComponent < BaseComponent
  COLOR_OVERRIDES = {
    black: %w(
      active:bg-gray-700
      active:text-gray-200
      bg-gray-900
      border-gray-800
      dark:disabled:bg-gray-400
      disabled:bg-gray-400
      disabled:text-gray-600
      hover:bg-gray-700
      text-gray-100
    ),
    gray: %w(
      active:bg-gray-400
      active:border-gray-400
      active:text-gray-800
      bg-gray-200
      border-gray-200
      dark:active:bg-gray-600
      dark:bg-gray-800
      dark:border-gray-800
      dark:disabled:bg-gray-400
      dark:hover:bg-gray-700
      dark:hover:text-gray-100
      dark:text-gray-200
      disabled:bg-gray-400
      disabled:text-gray-600
      hover:bg-gray-300
      hover:border-gray-300
      hover:text-gray-600
      relative
      text-gray-800
    ),
    blue: %w(
      active:bg-blue-light
      bg-blue
      border-transparent
      dark:text-gray-900
      disabled:bg-gray-400
      hover:bg-blue-dark
      text-white
    ),
    green: %w(
      active:bg-green-light
      bg-green
      border-transparent
      dark:text-gray-900
      disabled:bg-gray-400
      disabled:text-gray-600
      focus:ring-green
      hover:bg-green-dark
      text-white
    ),
    red: %w(
      border-red
      active:bg-red-dark
      bg-white
      dark:bg-gray-1000
      dark:hover:bg-red
      dark:hover:text-gray-900
      text-red
      disabled:bg-gray-400
      disabled:text-gray-600
      focus:ring-red
      hover:bg-red
      hover:text-white
    )
  }.freeze

  class << self
    def button_classes(color = :blue, additional_classes = '')
      base_classes = %w(
        border
        cursor-pointer
        disabled:cursor-not-allowed
        duration-150
        ease-in-out
        focus:outline-none
        font-semibold
        inline-block
        leading-5
        px-4
        py-2
        rounded-md
        transition
      )
      "#{additional_classes} #{base_classes.concat(button_color_classes(color)).join(' ')}"
    end

    private

    def button_color_classes(color)
      COLOR_OVERRIDES[color.to_sym] || colorized_classes(color)
    end

    def colorized_classes(color)
      %W(
        border-transparent
        active:bg-#{color}-800
        bg-#{color}-700
        focus:ring-#{color}
        hover:bg-#{color}-800
      )
    end
  end

  def initialize(
    text: nil, url: nil, icon: nil, color: :gray, classes: nil, show_loading: false, **options
  )
    @text = text
    @url = url
    @icon = icon
    @color = color
    @options = options
    @classes = @options.delete(:class) || classes
    @show_loading = show_loading
  end

  def link?
    @url.present?
  end

  def button_data
    { controller: 'button-loading' } if @show_loading
  end

  def button_class
    self.class.button_classes(
      @color,
      [
        @classes,
        (@icon.presence || @show_loading) && 'inline-flex items-center justify-center'
      ].compact.join(' ')
    )
  end
end
