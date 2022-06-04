# frozen_string_literal: true

module CoreRedirectable
  extend ActiveSupport::Concern

  def redirect_to_core(path)
    redirect_to core_redirect_path(to: path)
  end
end
