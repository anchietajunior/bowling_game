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
      return "in_progress" unless finished?
      return "finished"    if finished?
    end

    def finished?
      return false unless game_in_last_frame?
      return true if game_in_last_frame? && last_frame_is_finished?
      false
    end

    def game_in_last_frame?
      game.frames.count == 10
    end

    def last_frame_is_finished?
      game.frames.last.attempts.count == 3
    end
  end
end