module Feedjira

  module Parser
    # Parser for dealing with Atom feed entries.
    class AtomEntry
      include SAXMachine
      include FeedEntryUtilities

      element :title
      element :link, :as => :url, :value => :href, :with => {:type => "text/html", :rel => "alternate"}
      element :name, :as => :author
      element :content
      element :summary

      element :"media:content", :as => :image, :value => :url
      element :enclosure, :as => :image, :value => :href

      element :published
      element :id, :as => :entry_id
      element :created, :as => :published
      element :issued, :as => :published
      element :updated
      element :modified, :as => :updated
      elements :category, :as => :categories, :value => :term
      elements :link, :as => :links, :value => :href

      def url
        @url ||= links.first
      end

      def summary_image
        Loofah.xml_fragment(self.summary).xpath('.//img').map{|n|n.get_attribute('src')}.find_all{|src|src}.first
      end

      def content_image
        Loofah.xml_fragment(self.content).xpath('.//img').map{|n|n.get_attribute('src')}.find_all{|src|src}.first
      end
    end

  end

end
