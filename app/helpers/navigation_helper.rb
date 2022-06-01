# frozen_string_literal: true

module NavigationHelper
  DESKTOP_LINK = %w(
    group
    flex
    items-center
    justify-start
    px-4
    hover:text-blue
    relative
  ).freeze
  DESKTOP_ACTIVE_LINK = %w(
    text-blue
  ).freeze
  DESKTOP_INACTIVE_LINK = %w(
  ).freeze
  MOBILE_LINK = %w(
    block
    font-medium
    px-4
    py-2
    text-base
    flex
    items-center
    space-x-3
  ).freeze
  MOBILE_ACTIVE_LINK = %w(
    active-icon
  ).freeze
  MOBILE_INACTIVE_LINK = %w(
    border-transparent
  ).freeze

  def navigation_link(
    name,
    url,
    active: :exclusive,
    icon: nil,
    icon_only: false,
    **options
  )
    active_link_to(
      url,
      {
        class: class_string(DESKTOP_LINK),
        class_active: class_string(DESKTOP_ACTIVE_LINK),
        class_inactive: class_string(DESKTOP_INACTIVE_LINK),
        active:
      }.deep_merge(options)
    ) do
      concat(render(IconComponent.new(name: icon, class: 'w-5 h-5 m-2'))) if icon.present?
      concat(tag.div(class: 'ml-4 inline') { name }) unless icon_only
    end
  end

  def mobile_navigation_link(
    name,
    url,
    active: :exclusive,
    icon: nil,
    **options
  )
    active_link_to(
      url,
      {
        class: class_string(MOBILE_LINK),
        class_active: class_string(MOBILE_ACTIVE_LINK),
        class_inactive: class_string(MOBILE_INACTIVE_LINK),
        active:
      }.deep_merge(options)
    ) do
      concat(render(NavigationIconComponent.new(name: icon))) if icon.present?
      concat(tag.div(class: 'inline') { name })
    end
  end

  private

  def class_string(classes)
    classes.join(' ')
  end
end
