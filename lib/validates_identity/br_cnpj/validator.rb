# frozen_string_literal: true

class ValidatesIdentity
  module BrCnpj
    class Validator
      VALIDATION_REGULAR_EXPRESSION = %r{^(\d{2}\.?\d{3}\.?\d{3}/?\d{4})-?(\d{2})$}.freeze
      FORMAT_REGULAR_EXPRESSION = /(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/.freeze

      attr_reader :value

      def initialize(value)
        @value = value
      end

      def valid?
        return true if value.blank?
        return false unless number
        return false if striped_value.length != 14
        return false if striped_value.scan(/\d/).uniq.length == 1

        verifier_digits == "#{first_digit_verifier}#{second_digit_verifier}"
      end

      def formatted
        return if number.nil?

        result = FORMAT_REGULAR_EXPRESSION.match(striped_value)
        "#{result[1]}.#{result[2]}.#{result[3]}/#{result[4]}-#{result[5]}"
      end

      private

      def result
        @result ||= VALIDATION_REGULAR_EXPRESSION.match(value)
      end

      def number
        return if result.nil?

        @number ||= result[1]
      end

      def striped_number
        return if number.nil?

        @striped_number ||= number.gsub(%r{[\./-]}, '')
      end

      def striped_value
        return if number.nil?

        @striped_value ||= value.gsub(%r{[\./-]}, '')
      end

      def verifier_digits
        return if result.nil?

        @verifier_digits ||= result[2]
      end

      def first_digit_verifier
        result = multiply_and_sum([5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2], striped_number)
        digit_verifier(result)
      end

      def second_digit_verifier
        result = multiply_and_sum([6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2], "#{striped_number}#{first_digit_verifier}")
        digit_verifier(result)
      end

      def multiply_and_sum(array, number)
        multiplications = []
        number.each_char.with_index { |char, index| multiplications[index] = char.to_i * array[index] }
        multiplications.inject(:+)
      end

      def digit_verifier(value)
        result = value % 11

        if result >= 2
          (11 - result).to_s
        else
          0.to_s
        end
      end
    end
  end
end
