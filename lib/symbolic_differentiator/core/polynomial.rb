# frozen_string_literal: true

module SymbolicDifferentiator
  # Polynomial class, contains monomials
  class Polynomial
    attr_accessor :monomials

    def initialize(monomials = [])
      simplify_constants(monomials)
      @monomials = monomials
    end

    def to_s
      terms = @monomials.map do |monomial|
        if monomial.coefficient.negative?
          monomial.to_s.sub('-', '- ')
        else
          "+ #{monomial}"
        end
      end

      terms[0].sub!('+ ', '') if terms[0].start_with?('+ ')
      terms.join(' ')
    end

    def add_monomial(monomial)
      @monomials.append(monomial)
      simplify_constants(monomials)
    end

    def simplify_constants(monomials)
      constants = monomials.select(&:is_constant)
      monomials.reject!(&:is_constant)
      sum_of_constants = constants.map(&:coefficient).reduce(0, :+)
      return if sum_of_constants.zero? && !monomials.empty?

      sum_monomial = Monomial.new(sum_of_constants, '', 0)
      monomials << sum_monomial
    end

    def self.from_s(string_polynomial)
      raise ArgumentError, Constants::INVALID_EXPONENT if string_polynomial.match?(/\^\s*[+-]/)

      parts = string_polynomial.split(/(?=[+-])/)
      monomials = parts.map { |x| Monomial.from_s(x) }.sort_by(&:coefficient)
      Polynomial.new(monomials)
    end
  end
end
