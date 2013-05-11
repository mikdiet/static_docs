require_dependency "static_docs/application_controller"

module StaticDocs
  class PagesController < ApplicationController
    def show
      @page = Page.matched(params[:page_path] || '')
    end
  end
end
