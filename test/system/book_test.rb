require "application_system_test_case"

class BookTest < ApplicationSystemTestCase

  test "visiting the index" do
    visit book_index_path

    take_screenshot

    assert_selector "h1", text: "Book#index"
  end
end
