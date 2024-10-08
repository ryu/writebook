class Books::SearchesController < ApplicationController
  include BookScoped

  def create
    @leaves = if query.present?
      book_leaves.highlight_matches(query).limit(50)
    else
      Leaf.none
    end
  end

  private
    def query
      params[:search]&.gsub(/[^[:word:]]/, " ")
    end

    def book_leaves
      @book.leaves.positioned
    end
end
