# frozen_string_literal: true

module Constants
  MONOMIAL_REGEX = /(?<sign>[+-]?)(?<coefficient>\d*(?:\.\d+)?)(?<variable>[a-zA-Z]*)(?:\^(?<exponent>-?\d+))?/.freeze
  INVALID_MONOMIAL = 'Некорректный одночлен'
  INVALID_EXPONENT = 'Строка содержит отрицательную степень'
end
