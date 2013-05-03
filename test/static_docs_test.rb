require 'test_helper'

class StaticDocsTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, StaticDocs
  end

  test 'setup' do
    assert_equal StaticDocs.sources[nil], 'sources/root'
    assert_equal StaticDocs.sources[:namespace], 'sources/namespace'

    assert StaticDocs.renderers[:default].keys.include? 'md'
  end
end
