# frozen_string_literal: true

class Audits::NameComponent < BaseComponent
  def initialize(audit:)
    @audit = audit
  end

  def call
    @audit.comment.match(%r{<span class="audit-highlight">(.+)</span>})&.[](1)
  end
end
