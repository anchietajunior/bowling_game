class Attempt < ApplicationRecord
  belongs_to :frame

  validates :frame, presence: true
end
