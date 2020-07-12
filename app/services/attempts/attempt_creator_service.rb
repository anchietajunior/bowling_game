module Attempts
  class AttemptCreatorService < ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      retrieve_game
      retrieve_frame
      Result.new(true, nil, create_attempt!)
    rescue StandardError => e
      Result.new(false, e.message, nil)
    end

    private

    attr_reader :params, :game, :frame

    def retrieve_game
      @game = Game.find(params[:game_id])
    end

    def retrieve_frame
      @frame = Frame.new
      @frame.game = game
      @frame.number = 1
      @frame.save!
    end

    def create_attempt!
      Attempt.create!(frame: frame, overtuned_pins: params[:overtuned_pins])
    end
  end
end