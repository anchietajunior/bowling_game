class Attempt < ApplicationRecord
  belongs_to :frame

  validates :frame, presence: true
  validates :overtuned_pins, presence: true
end
