require 'test_helper'

class UniversitiesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @univerity = universities(:Uppsala)
    @article = articles(:one)
  end

  test "should get new" do
    get universities_new_url
    assert_response :success
  end

  test "should display Uppsala univerity's articles" do
    get "/universities/#{@univerity.id}", params: {univerity: {id: @univerity.id}}
    assert_response :success
  end

end
