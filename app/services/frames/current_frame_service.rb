module Frames
  class CurrentFrameService < ApplicationService
    def initialize(game)
      @game = game
    end

    def call
      Result.new(true, nil, current_frame)
    rescue StandardError => e
      Result.new(false, e.message, nil)
    end

    private

    attr_reader :game

    def current_frame
      return last_frame unless finished?
      create_frame
    end

    def create_frame
      Frame.create!(game: game)
    end

    def finished?
      return true if tenth_frame_finished?
      return true if strike?(last_frame) && !tenth_frame?
      return true if spare?(last_frame) && !tenth_frame?
      false
    end

    def tenth_frame_finished?
      return true if tenth_frame? && last_frame_attempts == 3
      return true if tenth_frame? && spare?(last_frame)
      false
    end

    def tenth_frame?
      game_frames_count == 10
    end

    def strike?(frame)
      frame.attempts.order(:created_at).first.overtuned_pins == 10
    end

    def spare?(frame)
      frame.attempts.order(:created_at).first.overtuned_pins < 10 && last_frame_attempts == 2
    end

    def last_frame_attempts
      last_frame.attempts.count
    end

    def last_frame
      game.frames.order(:created_at).last
    end

    def game_frames_count
      game.frames.order(:created_at).count
    end
  end
end