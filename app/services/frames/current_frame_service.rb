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
      return create_frame if game_just_started? || finished?
      last_frame
    end

    def create_frame
      Frame.create!(game: game)
    end

    def game_just_started?
      game.frames.empty?
    end

    def finished?
      return true if tenth_frame_finished? 
      return true if last_frame_is_a_spare?
      return true if last_frame_is_a_strike? && !tenth_frame?
      false
    end

    def tenth_frame_finished?
      return true if tenth_frame? && last_frame_attempts_count == 3
      return true if tenth_frame? && last_frame_is_a_spare?
      false
    end

    def last_frame_is_a_strike?
      if last_frame.present? && last_frame.try(:attempts).present?
        return last_frame.attempts.any? { |attempt| attempt.overtuned_pins == 10 }
      end
      false
    end

    def last_frame_is_a_spare?
      if last_frame.present? && last_frame.try(:attempts).present?
        return last_frame.attempts.all? { |attempt| attempt.overtuned_pins < 10 } && last_frame_attempts_count > 1
      end
      false
    end

    def last_frame_attempts_count
      last_frame.attempts.count
    end

    def last_frame
      game.frames.order(:created_at).last
    end

    def tenth_frame?
      game_frames_count == 10
    end

    def game_frames_count
      game.frames.order(:created_at).count
    end
  end
end