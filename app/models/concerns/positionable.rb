module Positionable
  extend ActiveSupport::Concern

  included do
    scope :positioned, -> { order(:position) }

    around_create :insert_at_default_position
  end

  class_methods do
    def positioned_within(parent, association:)
      define_method :positioning_parent do
        send(parent)
      end

      define_method :all_positioned_siblings do
        positioning_parent.send(association).positioned
      end

      define_method :other_positioned_siblings do
        all_positioned_siblings.excluding(self)
      end

      private :positioning_parent, :all_positioned_siblings, :other_positioned_siblings
    end
  end

  def move_to_position(new_position)
    # TODO: update to repair gaps if records are deleted

    with_positioning_lock do
      if new_position > position
        other_positioned_siblings.where(position: position..new_position).update_all("position = position - 1")
      else
        other_positioned_siblings.where(position: new_position..position).update_all("position = position + 1")
      end

      self.position = new_position
      save!
    end
  end

  private
    def insert_at_default_position
      with_positioning_lock do
        set_default_position
        yield
      end
    end

    def set_default_position
      last_position = all_positioned_siblings.maximum(:position) || 0
      self.position = last_position.next
    end

    def with_positioning_lock(&block)
      positioning_parent.with_lock &block
    end
end
