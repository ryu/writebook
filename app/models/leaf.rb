class Leaf < ApplicationRecord
  belongs_to :book
  belongs_to :parent, class_name: "Leaf", required: false

  delegated_type :leafable, types: Leafable::TYPES, dependent: :destroy
end
