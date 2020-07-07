class GamesController < ApplicationController
  before_action :set_game, only: [:show]

  def show
    render json: @game
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      render json: @game, status: :created, location: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  private
    def set_game
      @game = Game.find(params[:id])
    end

    def game_params
      params.fetch(:game, {})
    end
end
