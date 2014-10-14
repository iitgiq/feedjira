module Feedjira

  module Parser
    class RSSImage
      include SAXMachine
      include FeedUtilities
      element :url
      element :title
      element :link
    end

    # Parser for dealing with RSS feeds.
    class RSS
      include SAXMachine
      include FeedUtilities
      element :rss, as: :version, value: :version
      element :title
      element :description
      element :link, :as => :url
      element :image, :class => RSSImage
      elements :item, :as => :entries, :class => RSSEntry

      attr_accessor :feed_url
      attr_accessor :hubs

      def self.able_to_parse?(xml) #:nodoc:
        (/\<rss|\<rdf/ =~ xml) && !(/feedburner/ =~ xml)
      end
    end
  end

end
