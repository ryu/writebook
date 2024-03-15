require "test_helper"

class Leaf::PositionableTest < ActiveSupport::TestCase
  setup do
    @leaves = books(:handbook).leaves.positioned
  end

  test "items are sorted in positioned order" do
    assert @leaves.first.position < @leaves.second.position

    assert_equal [ leaves(:welcome_section), leaves(:welcome_page), leaves(:summary_page) ], @leaves
  end

  test "items can be moved earlier" do
    leaves(:welcome_page).move_to_position(1)

    assert_equal [ leaves(:welcome_page), leaves(:welcome_section), leaves(:summary_page) ], @leaves.reload
  end

  test "items can be moved later" do
    leaves(:welcome_section).move_to_position(2)

    assert_equal [ leaves(:welcome_page), leaves(:welcome_section), leaves(:summary_page) ], @leaves.reload
  end

  test "items can be moved to their existing position" do
    leaves(:welcome_page).move_to_position(2)

    assert_equal [ leaves(:welcome_section), leaves(:welcome_page), leaves(:summary_page) ], @leaves
  end
end
