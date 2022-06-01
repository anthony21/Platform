# frozen_string_literal: true

module Auditable
  extend ActiveSupport::Concern

  included do
    before_create { add_audit_comment :create }
    before_update { changes_exist :update }
    before_destroy { add_audit_comment :destroy }

    audited except: %i(updated_at record_count), associated_with: :account
  end

  def changes_exist(action)
    add_audit_comment(action) if changed.present?
  end

  def add_audit_comment(action)
    action_string = I18n.t("audits.#{action}")
    self.audit_comment = "#{action_string} <span class=\"audit-highlight\">#{shown_name}</span>"
  end

  def shown_name
    try(:name) || display_name
  end
end
