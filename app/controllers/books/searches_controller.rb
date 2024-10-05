class Books::SearchesController < ApplicationController
  include BookScoped

  def create
    @pages = book_pages.search_in(params[:search]).limit(50)
  end

  private
    def book_pages
      Page.joins(:leaf).where(leaf: { book: @book })
    end
end
