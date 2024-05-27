# frozen_string_literal: true

module SymbolicDifferentiator
  # Monomial class, contains data of monomial
  class Monomial
    attr_accessor :coefficient, :variable_name, :exponent, :is_constant

    def initialize(coefficient, variable_name, exponent)
      unless variable_name.match?(/\A[a-zA-Z]*\z/) && variable_name.length <= 1 && exponent >= 0
        raise ArgumentError, Constants::INVALID_MONOMIAL
      end

      @coefficient = coefficient
      @variable_name = variable_name
      @exponent = exponent
      @is_constant = variable_name.empty? || coefficient.zero? || exponent.zero?
    end

    def to_s
      integer_coefficient = @coefficient.to_i
      coefficient_str = integer_coefficient == @coefficient ? integer_coefficient.to_s : @coefficient.to_s

      return coefficient_str if @is_constant
      return "#{coefficient_str}#{@variable_name}" if @exponent == 1

      "#{coefficient_str}#{@variable_name}^#{@exponent}"
    end

    def self.constant(number)
      Monomial.new(number, '', 0)
    end

    def self.from_s(monomial_str) # rubocop:disable Metrics/AbcSize
      monomial_str = monomial_str.gsub(/\s+/, '')
      match = monomial_str.match(Constants::MONOMIAL_REGEX)
      raise ArgumentError, Constants::INVALID_MONOMIAL if match.nil? || match[:variable].nil?

      sign = match[:sign].empty? ? '+' : match[:sign]
      coefficient_str = match[:coefficient].empty? ? '1' : match[:coefficient]
      coefficient = coefficient_str.to_f
      coefficient = -coefficient if sign == '-'
      variable = match[:variable]
      exponent = match[:exponent].nil? ? 1 : match[:exponent].to_i
      Monomial.new(coefficient, variable, exponent)
    end
  end
end
