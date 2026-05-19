# frozen_string_literal: true

module Jekyll
  # ai-103 태그 포스트 → /ai-103/:slug.html
  # tag2(기타) 태그 포스트 → /:slug.html (예: memo)
  class PostPermalinkGenerator < Generator
    safe true
    priority :lowest

    def generate(site)
      site.posts.docs.each do |post|
        next if post.data['permalink']

        tags = normalize_tags(post.data['tags'])
        if tags.include?('ai-103')
          post.data['permalink'] = "/ai-103/#{post.slug}.html"
        elsif tags.include?('tag2')
          post.data['permalink'] = "/#{post.slug}.html"
        end
      end
    end

    def normalize_tags(tags)
      case tags
      when String then [tags]
      when Array then tags.map(&:to_s)
      else []
      end
    end
  end
end
