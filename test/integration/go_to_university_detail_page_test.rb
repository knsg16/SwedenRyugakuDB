require 'test_helper'

class GoToUniversityDetailPageTest < ActionDispatch::IntegrationTest


  test "select uppsala university" do
    #ホーム画面に移動するかどうか
    get root_path
    assert_response :success
    #大学の選択肢の数
    assert_select "option", 2
    #ストックホルム大学を選択し、ストックホルム大学ページに遷移するか
    #post "/universities", params: { university: "", id: 2  }
  end
end
