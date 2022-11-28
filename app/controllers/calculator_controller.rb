# frozen_string_literal: true

# Calculator controller with Turbo AJAX
class CalculatorController < ApplicationController
  def input; end

  def result
    @calculator = CalculatorResult.new(calculator_params)
  end

  private

  def calculator_params
    params.permit(:x, :y, :operation)
  end
end
