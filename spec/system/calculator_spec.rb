# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Static content', type: :system do
  # автоматически создаем значения x и y
  let(:x_value) { Faker::Number.number(digits: 2) }
  let(:y_value) { Faker::Number.number(digits: 2) }

  # сценарий успешного складывания x + y
  scenario 'x + y' do
    visit root_path # переходим на страницы ввода

    fill_in :x, with: x_value # заполняем поле с name="x"
    fill_in :y, with: y_value # заполняем поле с name="y"

    choose('operation_+') # выбираем radio_button с id="operation_+"
    find('#calculate-btn').click # нажимаем на кнопку с id="calculate_btn"

    # ожидаем найти в контенере вывода правильное содержимое
    expect(find('#result-container')).to have_text("Полученный ответ: #{x_value + y_value}")
  end

  # сценарий успешного вычитания x - y
  scenario 'x - y' do
    visit root_path # переходим на страницу ввода

    fill_in :x, with: x_value # заполняем поле с name="x"
    fill_in :y, with: y_value # заполняем поле с name="y"

    choose('operation_-') # выбираем radio_button с id="operation_-"
    find('#calculate-btn').click # нажимаем на кнопку с id="calculate_btn"

    # ожидаем найти в контенере вывода правильное содержимое
    expect(find('#result-container')).to have_text("Полученный ответ: #{x_value - y_value}")
  end

  # сценарий успешного умножения x * y
  scenario 'x * y' do
    visit root_path # переходим на страницу ввода

    fill_in :x, with: x_value # заполняем поле с name="x"
    fill_in :y, with: y_value # заполняем поле с name="y"

    choose('operation_*') # выбираем radio_button с id="operation_*"
    find('#calculate-btn').click # нажимаем на кнопку с id="calculate_btn"

    # ожидаем найти в контенере вывода правильное содержимое
    expect(find('#result-container')).to have_text("Полученный ответ: #{x_value * y_value}")
  end

  # сценарий успешного деления x / y
  scenario 'x / y' do
    visit root_path # переходим на страницу ввода

    fill_in :x, with: x_value # заполняем поле с name="x"
    fill_in :y, with: y_value # заполняем поле с name="y"

    choose('operation_/') # выбираем radio_button с id="operation_/"
    find('#calculate-btn').click # нажимаем на кнопку с id="calculate_btn"

    # ожидаем найти в контенере вывода правильное содержимое
    expect(find('#result-container')).to have_text("Полученный ответ: #{x_value / y_value}")
  end

  # сценарий неправильного ввода формы
  scenario 'do not fill any values in form and click submit' do
    visit root_path # переходим на страницу ввода

    find('#calculate-btn').click # нажимаем на кнопку с id="calculate_btn"

    # ожидаем найти в контенере вывода содержимое с выводом всех ошибок модели
    CalculatorResult.new.errors.messages.each do |message|
      expect(find('#result-container')).to have_text(message)
    end
  end
end
