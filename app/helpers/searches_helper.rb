module SearchesHelper
  def search_box(book)
    render "books/searches/search", book: book
  end
end
