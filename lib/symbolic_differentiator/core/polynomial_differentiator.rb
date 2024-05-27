# frozen_string_literal: true

module SymbolicDifferentiator
  # Core differentiator class
  class PolynomialDifferentiator
    def differentiate_polynomial_from_s(polynomial_str, variable_name)
      polynomial = Polynomial.from_s(polynomial_str)
      differentiate_polynomial(polynomial, variable_name)
    end

    def differentiate_polynomial(polynomial, variable_name)
      new_polynomial = Polynomial.new
      polynomial.monomials.each do |monomial|
        new_monomial = differentiate_monomial(monomial, variable_name)
        new_polynomial.add_monomial(new_monomial) unless new_monomial.coefficient.zero?
      end
      new_polynomial
    end

    def differentiate_monomial_from_s(monomial_str, variable_name)
      monomial = Monomial.from_s(monomial_str)
      differentiate_monomial(monomial, variable_name)
    end

    def differentiate_monomial(monomial, variable_name)
      return Monomial.constant(0) if monomial.variable_name != variable_name

      new_coefficient = monomial.coefficient * monomial.exponent
      new_exponent = monomial.exponent - 1
      if new_exponent.zero?
        Monomial.new(new_coefficient, '', 0)
      else
        Monomial.new(new_coefficient, monomial.variable_name, new_exponent)
      end
    end
  end
end
