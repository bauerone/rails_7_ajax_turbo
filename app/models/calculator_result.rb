# frozen_string_literal: true

# называем модель CalcuatorResult (не наследуемся от ApplicationRecord)
class CalculatorResult
  include ActiveModel::Model # примешиваем методы для модели ActiveModel
  include ActiveModel::Validations # примешиваем методы для валидаций из ActiveModel

  attr_accessor :x, :y, :operation # создаем аттрибуты модели руками, так как здесь нет связи с таблицей в БД

  validates :x, :y, :operation, presence: { message: 'не может быть пустым' } # проверка на обязательное наличие полей
  validates :x, :y, format: { with: /\d/, message: 'должно быть числом' } # проврка x и y на числа

  # проверка operation на вхождение в заранее заданный список значений (-,+,*,/)
  validates :operation, inclusion: {
    in: %w[* / + -],
    message: 'не входит в список доступных операций'
  }

  # выполняем расчет сразу в модели, а не в контроллере
  def result
    x.to_f.send(operation, y.to_f)
  end
end
