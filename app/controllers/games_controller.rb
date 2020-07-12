class GamesController < ApplicationController
  before_action :set_game, only: [:show]

  def show
    result = Games::GameInfoService.call(@game)
    
    if result.success?
      render json: result.value, status: :ok
    else
      render json: { errors: result.error }, status: :bad
    end
  end

  def create
    @game = Game.new

    if @game.save
      render json: @game, status: :ok
    else
      render json: @game.errors, status: :bad
    end
  end

  private
    def set_game
      @game = Game.find(params[:id])
    end
end
