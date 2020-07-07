class AttemptsController < ApplicationController

  def create
    @attempt = Attempt.new(attempt_params)

    if @attempt.save
      render json: @attempt, status: :created, location: @attempt
    else
      render json: @attempt.errors, status: :unprocessable_entity
    end
  end

  private

    def attempt_params
      params.require(:attempt).permit(:overtuned_pins, :frame_id)
    end
end
