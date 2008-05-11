module WillPaginate
  class HotKeyLinkRender < LinkRenderer
    def to_html
      links = @options[:page_links] ? windowed_paginator : []
      # previous/next buttons
      links.unshift page_link_or_span(@collection.previous_page, 'disabled', @options[:prev_label], :hotkey => 'h')
      links.push    page_link_or_span(@collection.next_page,     'disabled', @options[:next_label], :hotkey => 'l')
      
      html = links.join(@options[:separator])
      @options[:container] ? @template.content_tag(:div, html, html_attributes) : html
    end

    def page_link_or_span(page, span_class = 'current', text = nil, link_options = {})
      text ||= page.to_s
      if page and page != current_page
        @template.link_to text, url_options(page), link_options
      else
        @template.content_tag :span, text, :class => span_class
      end
    end
  end
end

WillPaginate::ViewHelpers.pagination_options[:renderer] = WillPaginate::HotKeyLinkRender
