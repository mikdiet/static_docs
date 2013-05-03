module StaticDocs
  class Page < ActiveRecord::Base

    class << self
      def matched(path)
        namespace, _, namespaced_path = path.partition('/')
        namespaced_matched(namespaced_path, namespace) || namespaced_matched(path) || raise(ActiveRecord::RecordNotFound)
      end

      def namespaced_matched(path, namespace = nil)
        if path.present? && StaticDocs.namespaces.include?(namespace)
          where(:namespace => namespace, :path => path).first
        end
      end
    end

  end
end
