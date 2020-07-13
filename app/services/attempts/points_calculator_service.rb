module Attempts
  class PointsCalculatorService < ApplicationService
    def initialize(overtuned_pins, frame)
      @overtuned_pins = overtuned_pins
      @frame = frame
    end

    def call
      Result.new(true, nil, points)
    rescue StandardError => e
      Result.new(false, e.message, nil)
    end

    private

    attr_reader :overtuned_pins, :frame

    def points
      return overtuned_pins if common_attempt?
      return multiplied_points if last_attempt_was_a_strike? && !tenth_frame?
      overtuned_pins
    end

    def multiplied_points
      overtuned_pins * 2
    end

    def common_attempt?
      first_attempt_of_the_game? || !last_attempt_was_a_strike?
    end

    def first_attempt_of_the_game?
      game.frames.count == 1 && frame.attempts.empty?
    end

    def last_attempt_was_a_strike?
      last_attempt.overtuned_pins == 10
    end

    def tenth_frame?
      game.frames.count == 10
    end

    def game
      frame.game
    end

    def last_attempt
      Attempt.joins(:frame).where('frames.game_id = ?', game.id).order(:create_at).last
    end
  end
end