class Books::SearchesController < ApplicationController
  include BookScoped

  def create
    @leaves = @book.leaves.search(terms).favoring_title.limit(50)
  end

  private
    def terms
      params[:search]
    end
end
