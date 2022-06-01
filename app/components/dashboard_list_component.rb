# frozen_string_literal: true

class DashboardListComponent < BaseComponent
  def initialize(type:, list:)
    @type = type
    @list = list
  end

  def icon_name(item)
    {
      Account => 'house-user',
      Audience => 'screen-users',
      List => 'address-card',
      Core::Order => 'table-list',
      Core::Invoice => 'file-invoice-dollar'
    }[item_class(item)]
  end

  def icon_color(item)
    {
      Account => 'orange',
      Audience => 'blue',
      List => 'green',
      Core::Order => 'teal',
      Core::Invoice => 'indigo'
    }[item_class(item)]
  end

  def queue_text(item)
    {
      Core::Order => t('dashboard.order_ready', order: core_display_id(item)),
      Core::Invoice => t('dashboard.invoice_ready', invoice: core_display_id(item))
    }[item_class(item)]
  end

  def queue_link(item)
    {
      Core::Order => order_new_order_confirmations_path(item),
      Core::Invoice => pay_invoice_path(item)
    }[item_class(item)]
  end

  def queue?
    @type == 'queue'
  end

  private

  def item_class(item)
    queue? ? item.class : item.auditable_type.safe_constantize
  end

  def core_display_id(item)
    item_class(item) == Core::Invoice ? item.order_id : item.id
  end
end
