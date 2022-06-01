# frozen_string_literal: true

module FormHelper
  FIELD_CLASSES = %w(
    dark:bg-gray-1000
    block
    border
    duration-150
    ease-in-out
    placeholder-gray-600
    dark:placeholder-gray-400
    px-4
    py-4
    rounded-md
    sm:leading-5
    text-gray-900
    dark:text-gray-200
    transition
    w-full
  ).freeze

  def field_classes(has_errors: false)
    classes = if has_errors
                %w(border-red text-red dark:text-red placeholder-red dark:placeholder-red
                   focus:border-red focus:ring-red pr-10)
              else
                %w(border-gray-300 dark:border-gray-800 focus:border-blue
                   dark:focus:border-blue focus:ring-blue dark:focus:ring-blue)
              end
    classes.concat(FIELD_CLASSES)
  end
end
