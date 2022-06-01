# frozen_string_literal: true

class PaginationComponent < BaseComponent
  include Pagy::Frontend

  def initialize(pagy:, entry_name:)
    @pagy = pagy
    @entry_name = entry_name
  end

  def page_entries_info
    if @pagy.count == 1
      I18n.t('helpers.page_entries_info.one_entry', entry_name:)
    elsif @pagy.pages == 1
      I18n.t('helpers.page_entries_info.one_page', count: @pagy.count, entry_name:)
    else
      I18n.t(
        'helpers.page_entries_info.many_pages',
        from: @pagy.from,
        to: @pagy.to,
        count: number_with_delimiter(@pagy.count),
        entry_name:
      )
    end
  end

  def entry_name
    @entry_name.pluralize(@pagy.count)
  end
end
