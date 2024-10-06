require "test_helper"

class Page::SearchableTest < ActiveSupport::TestCase
  setup do
    Page.reindex_all
  end

  test "page body is indexed and searchable" do
    pages = Page.search("great handbook")
    assert_includes pages, pages(:welcome)
  end

  test "highlighting matches" do
    pages = Page.highlight_matches("great handbook")
    assert_includes pages.first.match, "<mark>great</mark> <mark>handbook</mark>"
  end
end
