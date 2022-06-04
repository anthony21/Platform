# frozen_string_literal: true

class PageHeaderSearchComponent < BaseComponent
  def initialize(url:, value: nil, placeholder: 'Search', user_filter: nil)
    @url = url
    @value = value
    @placeholder = placeholder
    @user_filter = user_filter
  end

  def user_filter_values
    [
      [I18n.t('views.table.all'), 'all'],
      [I18n.t('views.table.only_mine'), 'mine']
    ]
  end

  def selected_filter
    user_filter_values.find do |filter|
      filter[1] == @user_filter
    end
  end
end
