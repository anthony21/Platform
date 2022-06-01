# frozen_string_literal: true

module ApplicationHelper
  def title(page_title)
    content_for(:page_title) { page_title }
    content_for(:title) { page_title }
  end

  def subtitle(page_subtitle, prefix: ' - ')
    content_for(:page_title) { "#{prefix}#{page_subtitle}" }
    content_for(:subtitle) { page_subtitle }
  end

  def scoped_title(page_title)
    title(page_title)

    scoped_subtitle = scope_text('All')
    return if scoped_subtitle.blank?

    subtitle(scoped_subtitle, prefix: scoped_subtitle.include?('@') ? ' ' : ' - ')
  end

  def builder_layout?
    @layout == :builder
  end
end
