require "static_docs/engine"

module StaticDocs
  mattr_accessor :sources
  @@sources = {}

  mattr_accessor :renderers
  @@renderers = {
    :default => {
      :html => proc{ |body| body.html_safe },
      :txt => proc{ |body| body }
    }.with_indifferent_access
  }.with_indifferent_access

  def self.source(src, options = {})
    namespace = options[:namespace] || options[:to]
    @@sources[namespace] = src
  end

  def self.renderer(format, options = {}, &block)
    namespace = options[:namespace] || :default
    @@renderers[namespace] ||= {}.with_indifferent_access
    @@renderers[namespace][format] = block
  end

  def self.setup(&block)
    instance_eval(&block)
  end

end
