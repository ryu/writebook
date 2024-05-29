class PagesController < ApplicationController
  include SetBookLeaf

  before_action :forget_reading_progress, except: :show

  def new
    @page = Page.new
  end

  def create
    @leafable = new_page
    @book.press @leafable

    position_new_leaf(@leafable.leaf)

    respond_to do |format|
      format.turbo_stream { render }
      format.html { redirect_to @book }
    end
  end

  def show
  end

  def edit
  end

  def update
    @leaf.edit page_params

    respond_to do |format|
      format.turbo_stream { render }
      format.html { redirect_to leafable_url(@leaf) }
    end
  end

  def destroy
    @leaf.trashed!
    redirect_to @book
  end

  private
    def forget_reading_progress
      cookies.delete "reading_progress_#{@book.id}"
    end

    def position_new_leaf(leaf)
      if position = params[:position]&.to_i
        leaf.move_to_position position
      end
    end

    def new_page
      Page.new page_params
    end

    def page_params
      params.fetch(:page, {}).permit(:title, :body)
    end
end
