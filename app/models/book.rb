class Book < ApplicationRecord
  has_many :leafs, dependent: :destroy
end
