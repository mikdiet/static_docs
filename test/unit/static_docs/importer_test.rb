require 'test_helper'
require "static_docs/importer"

module StaticDocs
  class ImporterTest < ActiveSupport::TestCase
    fixtures 'static_docs/pages'

    def setup
      @importer = Importer.new(nil)
    end

    test 'source' do
      src = File.expand_path("../../../dummy/sources/root", __FILE__)
      assert_equal src, @importer.source.to_s
    end

    test 'config' do
      assert @importer.config['special'].present?
      assert @importer.config['pages'].present?
    end

    test 'cleanup' do
      @importer.cleanup
      assert_equal Page.find(static_docs_pages(:first_level_page).id), static_docs_pages(:first_level_page)
      assert_raise(ActiveRecord::RecordNotFound){ Page.find(static_docs_pages(:deep_page).id) }
    end

    test 'import root' do
      Importer.import(nil)
      main = Page.matched('home')
      assert_equal main.title, 'Main Page'
      assert_equal main.extension, 'html'
      assert_equal main.body, "<p>Hello from homepage!</p>\n"
      assert_equal main.namespace, nil

      assert_equal Page.matched('page').title, 'This is Just Page'
      assert_equal Page.matched('getting-started').title, 'Getting Started'
    end

    test 'import namespaced' do
      Importer.import('namespace')
      main = Page.matched('namespace/home')
      assert_equal main.title, 'Namespace Main Page'
      assert_equal main.extension, 'html'
      assert_equal main.body, "<p>Hello from namespace!</p>\n"
      assert_equal main.namespace, 'namespace'

      assert_equal Page.matched('namespace/page').title, 'This is Just Namespaced Page'
    end

  end
end
