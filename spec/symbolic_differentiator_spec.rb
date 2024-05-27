# frozen_string_literal: true

require 'rspec'
require 'symbolic_differentiator'

RSpec.describe SymbolicDifferentiator::PolynomialDifferentiator do # rubocop:disable Metrics/BlockLength
  describe '#differentiate_polynomial_from_s' do # rubocop:disable Metrics/BlockLength
    context 'Default valid string' do
      it 'returns the differentiated polynomial' do
        pd = SymbolicDifferentiator::PolynomialDifferentiator.new
        result = pd.differentiate_polynomial_from_s('2x^2 + 3x - x + y', 'x')
        expect(result.to_s).to eq('4x + 2')
      end
    end

    context 'Invalid string' do
      it 'returns the differentiated polynomial' do
        pd = SymbolicDifferentiator::PolynomialDifferentiator.new
        expect { pd.differentiate_polynomial_from_s('2x^-2+ 3x - x + y', 'x') }.to raise_error(ArgumentError)
      end
    end

    context 'Invalid string' do
      it 'raises ArgumentError' do
        pd = SymbolicDifferentiator::PolynomialDifferentiator.new
        expect { pd.differentiate_polynomial_from_s('invalid polynomial', 'x') }.to raise_error(ArgumentError)
      end
    end

    context 'Invalid string2' do
      it 'raises ArgumentError' do
        pd = SymbolicDifferentiator::PolynomialDifferentiator.new
        expect { pd.differentiate_polynomial_from_s('2xy^2', 'x') }.to raise_error(ArgumentError)
      end
    end

    context 'Differentiate by unused variable' do
      it 'returns 0' do
        pd = SymbolicDifferentiator::PolynomialDifferentiator.new
        result = pd.differentiate_polynomial_from_s('2x^2 + 3x - x + y', 'z')
        expect(result.to_s).to eq('0')
      end
    end

    context 'Differentiate string with multiple constants' do
      it 'sums up the constants and returns differentiated polynomial' do
        pd = SymbolicDifferentiator::PolynomialDifferentiator.new
        result = pd.differentiate_polynomial_from_s('2x^2 + 3x - 4x + y', 'x')
        expect(result.to_s).to eq('4x - 1')
      end
    end

    context 'Differentiate string with multiple numbers' do
      it 'returns differentiated polynomial' do
        pd = SymbolicDifferentiator::PolynomialDifferentiator.new
        result = pd.differentiate_polynomial_from_s('2x^2 + 3 - 4', 'x')
        expect(result.to_s).to eq('4x')
      end
    end

    context 'when polynomial string is empty' do
      it 'returns zero polynomial' do
        pd = SymbolicDifferentiator::PolynomialDifferentiator.new
        result = pd.differentiate_polynomial_from_s('', 'x')
        expect(result.to_s).to eq('0')
      end
    end

    context 'when polynomial string contains only one monomial' do
      it 'returns the differentiated monomial' do
        pd = SymbolicDifferentiator::PolynomialDifferentiator.new
        result = pd.differentiate_polynomial_from_s('2x^2', 'x')
        expect(result.to_s).to eq('4x')
      end
    end
  end

  describe '#differentiate_monomial_from_s' do
    context 'when monomial string is valid' do
      it 'returns the differentiated monomial' do
        pd = SymbolicDifferentiator::PolynomialDifferentiator.new
        result = pd.differentiate_monomial_from_s('3x^2', 'x')
        expect(result.to_s).to eq('6x')
      end
    end

    context 'when monomial string is invalid' do
      it 'raises ArgumentError' do
        pd = SymbolicDifferentiator::PolynomialDifferentiator.new
        expect { pd.differentiate_monomial_from_s('invalid monomial', 'x') }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#differentiate_monomial_from_s' do
    context 'when monomial string is valid' do
      it 'returns the differentiated monomial' do
        pd = SymbolicDifferentiator::PolynomialDifferentiator.new
        result = pd.differentiate_monomial_from_s('2x^2', 'x')
        expect(result.to_s).to eq('4x')
      end
    end

    context 'when monomial string is invalid' do
      it 'raises ArgumentError' do
        pd = SymbolicDifferentiator::PolynomialDifferentiator.new
        expect { pd.differentiate_monomial_from_s('invalid monomial', 'x') }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#differentiate_monomial' do
    context 'when monomial object is valid' do
      it 'returns the differentiated monomial' do
        pd = SymbolicDifferentiator::PolynomialDifferentiator.new
        monomial = SymbolicDifferentiator::Monomial.new(2, 'x', 2)
        result = pd.differentiate_monomial(monomial, 'x')
        expect(result.to_s).to eq('4x')
      end
    end

    context 'when monomial object is invalid' do
      it 'raises ArgumentError' do
        expect do
          SymbolicDifferentiator::Monomial.new(2, 'x', -1)
        end.to raise_error(ArgumentError)
      end
    end
  end
end
