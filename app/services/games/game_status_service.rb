module Games
  class GameStatusService < ApplicationService
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
        points: 0
      }
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