class CalculatorController < ApplicationController
  def input
  end

  def result
    x_value = params[:x].to_f # достаем значение x и приводим его к числу
    y_value = params[:y].to_f # достаем значение y и приводим его к числу
    @result = x_value.send(params[:operation], y_value) # считаем результат
  end
end
