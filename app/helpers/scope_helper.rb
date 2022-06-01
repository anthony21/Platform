# frozen_string_literal: true

module ScopeHelper
  def scope_text(all_text = nil)
    if @account.present?
      @account == Current.account ? nil : "@ #{@account.name}"
    else
      all_text || 'Urban Outlets'
    end
  end
end
