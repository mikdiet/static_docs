module StaticDocs
  class Importer
    attr_accessor :namespace

    def self.import(namespace)
      new(namespace).import
    end

    def initialize(namespace)
      @namespace = namespace
    end

    def source
      @source ||= Rails.root.join StaticDocs.sources[namespace]
    end

    def config
      @config ||= YAML.load IO.read File.join source, 'index.yml'
    end

    def import
      cleanup
      import_collection config['special'], false
      import_collection config['pages']
    end

    def import_collection(pages, show = true)
      return if pages.empty?
      pages.each_with_index do |data, index|
        page = Page.where(:namespace => namespace, :path => data['path']).first_or_initialize
        page.extension = data['file'][/([^\.]+)$/]
        page.position = show ? index : nil if page.attributes.include?('position')
        page.title = data['title']
        page.body = File.read File.join(source, data['file'])
        page.save
      end
    end

    def cleanup
      actual_page_urls = (config['pages'] + config['special']).map{ |page| page['path'] }
      Page.where(:namespace => namespace).where('path not in (?)', actual_page_urls).destroy_all
    end
  end
end
