# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Calculators', type: :request do
  # Тестируем корневой маршрут
  describe 'GET /' do
    before { get root_path } # перед каждым тестом делать запрос

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders input template' do
      expect(response).to render_template(:input)
    end

    it 'responds with html' do
      expect(response.content_type).to match(%r{text/html})
    end
  end

  # Тестируем маршрут вывода результата
  describe 'GET /result' do
    # Сценарий, когда параметры неправильные
    context 'when params are invalid' do
      before {  post result_path, xhr: true } # перед каждым тестом делать запрос (xhr: true - значит асинхронно)

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'renders result templates' do
        expect(response).to render_template(:result)
        expect(response).to render_template(:_result_message)
      end

      it 'responds with turbo stream' do
        expect(response.content_type).to match(%r{text/vnd.turbo-stream.html})
      end

      it 'assigns invalid model object' do
        expect(assigns(:calculator).valid?).to be false
      end
    end

    # Сценарий, когда парамаетры правильные
    context 'when params are ok' do
      # создаем случайные значения
      let(:x_param) { Faker::Number.number(digits: 3) }
      let(:y_param) { Faker::Number.number(digits: 3) }
      let(:operation_param) { ['+', '-', '*', '/'].sample }

      # перед каждым тестом делать запрос (params - параметры запроса, xhr: true - выполнить асинхронно)
      before { post result_path, params: { x: x_param, y: y_param, operation: operation_param }, xhr: true }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'renders result templates' do
        expect(response).to render_template(:result)
        expect(response).to render_template(:_result_message)
      end

      it 'responds with turbo stream' do
        expect(response.content_type).to match(%r{text/vnd.turbo-stream.html})
      end

      it 'assigns valid model object' do
        expect(assigns(:calculator).valid?).to be true
      end
    end
  end
end
