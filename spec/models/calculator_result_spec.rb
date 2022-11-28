# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CalculatorResult, type: :model do
  # тестируем валидации
  describe 'validations' do
    # тестируем, что модель проверяет наличие параметров и выводит соответствующее сообщение
    it { should validate_presence_of(:x).with_message('не может быть пустым') }
    it { should validate_presence_of(:y).with_message('не может быть пустым') }
    it { should validate_presence_of(:operation).with_message('не может быть пустым') }

    # тестируем, что модель проверяет параметр operation на вхождение в список
    it do
      should validate_inclusion_of(:operation).in_array(%w[* / + -])
                                              .with_message('не входит в список доступных операций')
    end

    # тестируем валидации, когда x и y не являются числами
    context 'when x or y are not digits' do
      it { should_not allow_value(Faker::Lorem.word).for(:x) }
      it { should_not allow_value(Faker::Lorem.word).for(:y) }
    end

    # тестируем валидации, когда x и y являются числами
    context 'when x or y are digits' do
      it { should allow_value(Faker::Number.number).for(:x) }
      it { should allow_value(Faker::Number.number).for(:y) }
    end
  end

  # тестируем работу метода result
  describe '#result' do
    let(:x_param) { Faker::Number.number.to_f }
    let(:y_param) { Faker::Number.number.to_f }
    let(:params) { { x: x_param, y: y_param, operation: operation_param } }

    subject { described_class.new(params) }

    context 'when operation is +' do
      let(:operation_param) { '+' }

      it 'should sum values' do
        expect(subject.result).to eq(x_param + y_param)
      end
    end

    context 'when operation is -' do
      let(:operation_param) { '-' }

      it 'should subtract values' do
        expect(subject.result).to eq(x_param - y_param)
      end
    end

    context 'when operation is *' do
      let(:operation_param) { '*' }

      it 'should multiply values' do
        expect(subject.result).to eq(x_param * y_param)
      end
    end

    context 'when operation is /' do
      let(:operation_param) { '/' }

      it 'should divide values' do
        expect(subject.result).to eq(x_param / y_param)
      end
    end
  end
end
