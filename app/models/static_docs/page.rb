module StaticDocs
  class Page < ActiveRecord::Base
    attr_accessor :meta

    class << self
      def matched(path)
        namespace, _, namespaced_path = path.partition('/')
        namespaced_matched(namespaced_path, namespace) || namespaced_matched(path) || raise(ActiveRecord::RecordNotFound)
      end

      def namespaced_matched(path, namespace = nil)
        if StaticDocs.namespaces.include?(namespace)
          path = 'index' unless path.present?
          where(:namespace => namespace, :path => path).first
        end
      end
    end

    def meta
      @meta ||= {}
    end

    def renderer
      @renderer ||= StaticDocs.renderers[namespace].try(:fetch, extension) || StaticDocs.renderers[:default][extension]
    end

    def rendered_body(context)
      context.instance_exec(body, self, &renderer)
    end
  end
end
