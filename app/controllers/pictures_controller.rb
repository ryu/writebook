class PicturesController < ApplicationController
  include SetBookLeaf

  def new
    @picture = Picture.new
  end

  def create
    @leafable = new_picture
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
    @leaf.edit picture_params

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
    def position_new_leaf(leaf)
      if position = params[:position]&.to_i
        leaf.move_to_position position
      end
    end

    def new_picture
      Picture.new picture_params
    end

    def picture_params
      params.fetch(:picture, {}).permit(:title, :image, :caption)
    end
end
