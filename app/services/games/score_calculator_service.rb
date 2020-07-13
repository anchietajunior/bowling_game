module Games
  class ScoreCalculatorService < ApplicationService
    def initialize(game)
      @game = game
    end

    def call
      Result.new(true, nil, score)
    rescue StandardError => e
      Result.new(false, e.message, nil)
    end

    private

    attr_reader :game

    def score
      Attempt.joins(:frame).where('frames.game_id = ?', game.id).sum(:points)
    end
  end
end