module StaticDocs
  class Page < ActiveRecord::Base

    class << self
      def matched(path)
        namespace, _, namespaced_path = path.partition('/')
        page = where(:namespace => namespace, :path => namespaced_path).first if namespaced_path.present?
        page ||= where(:namespace => nil, :path => path).first
        page || raise(ActiveRecord::RecordNotFound)
      end
    end

  end
end
