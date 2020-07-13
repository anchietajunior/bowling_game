module Games
  class GameInfoService < ApplicationService
    def initialize(game)
      @game = game
    end

    def call
      raise "Game not found" unless game
      initialize_game_info
      build_frames
      Result.new(true, nil, game_info)
    rescue StandardError => e
      Result.new(false, e.message, nil)
    end

    private

    attr_reader :game, :game_info

    def initialize_game_info
      @game_info = {
        id: game.id,
        status: status,
        frames: {},
        score: score
      }
    end

    def score
      Games::ScoreCalculatorService.call(game).value
    end

    def build_frames
      game.frames.order(:created_at).each_with_index do |frame, index|
        game_info[:frames]["#{index+1}"] = frame_attempts(frame)
      end
    end

    def frame_attempts(frame)
      {}.tap do |hash|
        frame.attempts.order(:created_at).each_with_index do |attempt, index|
          hash["#{index+1}"] = {
            overtuned_pins: attempt.overtuned_pins
          }
        end
      end
    end

    def status
      Games::GameStatusService.call(game).value
    end
  end
end