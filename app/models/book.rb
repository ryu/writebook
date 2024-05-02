class Book < ApplicationRecord
  has_many :leaves, dependent: :destroy
  has_many :accesses, dependent: :destroy

  has_one_attached :cover

  scope :ordered, -> { order(:title) }

  def editable?(user: Current.user)
    accesses.editor.exists?(user: user)
  end

  def press(leafable)
    transaction do
      leafable.save!
      leaves.create! leafable: leafable
    end
  end
end
