module Attempts
  class AttemptCreatorService < ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      raise "This Game is finished" if game_finished?
      Result.new(true, nil, create_attempt!)
    rescue StandardError => e
      Result.new(false, e.message, nil)
    end

    private

    attr_reader :params

    def game
      Game.find(params[:game_id])
    end

    def frame
      Frames::CurrentFrameService.call(game).value
    end

    def create_attempt!
      Attempt.create!(frame: frame, overtuned_pins: params[:overtuned_pins])
    end

    def game_finished?
      Games::GameStatusService.call(game).value == "finished"
    end
  end
end