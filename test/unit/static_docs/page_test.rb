require 'test_helper'

module StaticDocs
  class PageTest < ActiveSupport::TestCase
    fixtures 'static_docs/pages'

    test "first-level search of matched page" do
      assert_equal Page.matched('page'), static_docs_pages(:first_level_page)
    end

    test "deep search of matched page" do
      assert_equal Page.matched('path/to/page'), static_docs_pages(:deep_page)
    end

    test "namespaced search of matched page" do
      assert_equal Page.matched('namespace/page'), static_docs_pages(:namespaced_page)
    end

    test "search of nonexistent page" do
      assert_raise(ActiveRecord::RecordNotFound){ Page.matched('wrong') }
    end
  end
end
