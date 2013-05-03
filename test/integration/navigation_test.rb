require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest
  fixtures :all

  test 'browse pages' do
    get '/'
    assert_response :success
    assert_select 'title', {:text => 'Dummy'}, 'Page must be rendered within application layout'
    assert_select 'h3', {:text => 'This is home page'}

    get '/page'
    assert_response :success
    assert_select 'h3', {:text => 'This is first level page'}
    assert_select 'body', /This is first level page/

    get '/namespace/page'
    assert_response :success
    assert_select 'h3', {:text => 'This is namespaced page'}

    get '/markdown'
    assert_response :success
    assert_select 'pre', {:text => '### This is markdown page'}

    get '/wrong'
    assert_response :not_found
  end
end
