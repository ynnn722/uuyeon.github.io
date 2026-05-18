# frozen_string_literal: true

module Jekyll
  module TitleSortFilter
    # Leading numbers first (01, 02, …), then titles without a leading number (A–Z / locale).
    def sort_by_title(input)
      return input unless input.is_a?(Array)

      input.sort_by { |item| sort_key(item) }
    end

    private

    def sort_key(item)
      title = extract_title(item)
      if (m = title.match(/\A\s*(\d+)/))
        [0, m[1].to_i, title.downcase]
      else
        [1, title.downcase]
      end
    end

    def extract_title(item)
      if item.respond_to?(:[])
        item['title'].to_s
      else
        item.to_s
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::TitleSortFilter)
