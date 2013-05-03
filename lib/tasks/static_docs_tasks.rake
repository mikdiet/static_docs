require "static_docs/importer"

namespace :static_docs do
  desc "Import pages to database. Use `namespace=xxx` or `namespaces=xxx,yyy` to point what namespace to import. Use keyword `root` to point on root namespace."
  task :import => :environment do
    namespaces = (ENV['namespace'] || ENV['namespaces']).try(:split, ',')
    (namespaces ? namespaces.map{ |n| n == 'root' ? nil : n } & c.namespaces : StaticDocs.namespaces).each do |namespace|
      StaticDocs::Importer.import(namespace)
    end
  end
end
