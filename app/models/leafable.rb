module Leafable
  extend ActiveSupport::Concern

  TYPES = %w[ Page Section ]

  included do
    has_one :leaf, as: :leafable, inverse_of: :leavable, touch: true
  end
end
