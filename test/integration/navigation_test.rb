require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest
  self.fixture_path = File.expand_path("../../fixtures/", __FILE__)
  fixtures :all

  test 'browse pages' do
    get '/'
    assert_response :success
    assert_select 'title', {:text => 'Dummy'}, 'Page must be rendered within application layout'
    assert_select 'h3', {:text => 'This is home page'}

    get static_docs.page_path(static_docs_pages(:first_level_page))
    assert_response :success
    assert_select 'h3', {:text => 'This is first level page'}
    assert_select 'body', /This is first level page/

    get static_docs.page_path(static_docs_pages(:namespaced_page))
    assert_response :success
    assert_select 'h3', {:text => 'This is namespaced page'}

    get '/markdown'
    assert_response :success
    assert_select 'pre', {:text => '### This is markdown page'}

    get '/wrong'
    assert_response :not_found
  end
end
