require_dependency "static_docs/application_controller"

module StaticDocs
  class PagesController < ApplicationController
    def index
      @page = Page.matching("home")
      render :show
    end

    def show
      @page = Page.matching(params[:page_path])
    end
  end
end
