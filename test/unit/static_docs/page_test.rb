require 'test_helper'

module StaticDocs
  class PageTest < ActiveSupport::TestCase
    fixtures 'static_docs/pages'

    setup do
      @view_context = Object.new.extend ::ApplicationHelper
    end

    test "first-level search of matched page" do
      assert_equal Page.matched('page'), static_docs_pages(:first_level_page)
    end

    test "deep search of matched page" do
      assert_equal Page.matched('path/to/page'), static_docs_pages(:deep_page)
    end

    test "namespaced search of matched page" do
      assert_equal Page.matched('namespace/page'), static_docs_pages(:namespaced_page)
    end

    test "search in unregistered namespace" do
      assert_raise(ActiveRecord::RecordNotFound){ Page.matched('wrong/page') }
    end

    test "search of nonexistent page" do
      assert_raise(ActiveRecord::RecordNotFound){ Page.matched('wrong') }
    end

    test 'simple renderer' do
      assert_equal Page.matched('page').rendered_body(@view_context), '<h3>This is first level page</h3>'
    end

    test 'contextual renderer' do
      str = "<h1>This is original markdown text</h1><pre>### This is markdown page</pre>"
      assert_equal Page.matched('markdown').rendered_body(@view_context), str
    end

    test 'meta setting in renderer' do
      page = Page.matched('text')
      assert_equal page.rendered_body(@view_context), 'testtesttest'
      assert_equal page.meta[:test], 'test'
    end
  end
end
