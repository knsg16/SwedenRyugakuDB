require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  test "should get root" do
    get root_url
    assert_response :success
  end
  test "should get home" do
    get static_pages_home_url
    assert_response :success
    assert_select "title", "Home | Sweden Ryugaku DB"
  end

  test "should get about" do
    get static_pages_about_url
    assert_response :success
    assert_select "title", "About | Sweden Ryugaku DB"
  end

  test "should get contact" do
    get static_pages_contact_url
    assert_response :success
    assert_select "title", "Contact | Sweden Ryugaku DB"
  end

end
