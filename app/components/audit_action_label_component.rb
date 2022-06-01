# frozen_string_literal: true

class AuditActionLabelComponent < BaseComponent
  def initialize(audit:)
    @audit = audit
  end

  def color
    {
      'create' => 'green',
      'update' => 'blue',
      'destroy' => 'red'
    }[@audit.action]
  end
end
