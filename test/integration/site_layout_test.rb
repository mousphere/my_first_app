require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path
    assert_select "a.nav-link", count: 4
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", new_user_path
  end
end
