class AttemptsController < ApplicationController

  def create
    result = Attempts::AttemptCreatorService.call(attempt_params)

    if result.success?
      render json: result.value, status: :ok
    else
      render json: { errors: result.error }, status: :unprocessable_entity
    end
  end

  private

    def attempt_params
      params.require(:attempt).permit(:overtuned_pins, :game_id)
    end
end
