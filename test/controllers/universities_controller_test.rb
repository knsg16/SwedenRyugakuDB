require 'test_helper'

class UniversitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get universities_new_url
    assert_response :success
  end

end
