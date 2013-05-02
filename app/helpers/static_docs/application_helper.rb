module StaticDocs
  module ApplicationHelper
    def respond_to?(method)
      super || main_app.respond_to?(method)
    end

    def method_missing(method, *args, &block)
      if main_app.respond_to?(method)
        main_app.send(method, *args, &block)
      else
        super
      end
    end
  end
end
