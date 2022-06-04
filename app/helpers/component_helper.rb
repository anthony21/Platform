# frozen_string_literal: true

module ComponentHelper
  Dir.glob(Rails.root.join('app', 'components', '**', '*.rb')).each do |component_file|
    component = component_file.match(%r{app/components/([\w_/]+)_component.rb})[1]
    component_shorthand = component.tr('/', '_')

    define_method component_shorthand do |**options, &block|
      render "#{component.camelize}Component".constantize.new(**options), &block
    end
  end
end
