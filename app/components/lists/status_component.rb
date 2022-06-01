# frozen_string_literal: true

class Lists::StatusComponent < BaseComponent
  def initialize(list:)
    @list = list
  end

  def icon_name
    {
      'ready' => 'check',
      'failed' => 'xmark'
    }.fetch(@list.status, 'spinner-third')
  end

  def show_spinner?
    %w(submitted processing).include?(@list.status)
  end

  def status_color
    {
      'ready' => 'text-green',
      'failed' => 'text-red-700 dark:text-red-300'
    }.fetch(@list.status, 'text-gray-600 dark:text-gray-300')
  end
end
