class Leaf < ApplicationRecord
  belongs_to :book
  belongs_to :parent

  delegated_type :leafable, types: Leafable::TYPES, dependent: :destroy
end
