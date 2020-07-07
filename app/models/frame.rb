class Frame < ApplicationRecord
  belongs_to :game
  has_many :attempts

  validates :game_id, presence: true
  validates :number, presence: true
end
