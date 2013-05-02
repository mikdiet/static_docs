require_dependency "static_docs/application_controller"

module StaticDocs
  class PagesController < ApplicationController
    def index
      @page = Page.matched("home")
      render :show
    end

    def show
      @page = Page.matched(params[:page_path])
    end
  end
end
