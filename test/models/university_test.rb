require 'test_helper'

class UniversityTest < ActiveSupport::TestCase

  def setup
    @univerity = University.new(name: "東京大学")
  end

  test "should be present" do
    assert @univerity.valid?
  end

  test "name should be present" do
    @univerity.name = "   "
    assert_not @univerity.valid?
  end

  test "name should not be too long" do
    @univerity.name = "a" * 51
    assert_not @univerity.valid?
  end
end
