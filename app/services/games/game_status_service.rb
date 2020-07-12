module Games
  class GameStatusService < ApplicationService
    def initialize(game)
      @game = game
    end

    def call
      Result.new(true, nil, game_status)
    rescue StandardError => e
      Result.new(false, e.message, nil)
    end

    private

    attr_reader :game

    def game_status
      {}.tap do |hash|
        hash[:id]     = game.id
        hash[:status] = "in_progress"
      end
    end
  end
end