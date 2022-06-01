# frozen_string_literal: true

module List::Auditable
  extend ActiveSupport::Concern
  include Auditable

  def add_audit_comment(action)
    if changed == %w(status updated_at)
      action_string = I18n.t("lists.status_change.#{status_change.last}")
      self.audit_comment = "<span class=\"audit-highlight\">#{name}</span> #{action_string}"
    elsif changed != %w(record_count updated_at)
      super
    end
  end
end
