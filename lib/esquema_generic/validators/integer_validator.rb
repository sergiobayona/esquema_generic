require_relative 'base_validator'

module EsquemaGeneric
  module Validators
    class IntegerValidator < BaseValidator
      # valid options are: 1, "1", any integer, or any integer wrapped in a string.
      # invalid options are: 1.5, "1.5", "-1", -1, %w[1 2], null, Object, [], {} or anything that's not an positive integer or an integer wrapped in a string.
      def validate
        return if @value.is_a?(Integer) && @value > 0 || @value.is_a?(String) && @value.match?(/\A[1-9]\d*\z/)

        raise ArgumentError,
              "Value of '#{@constraint}' in '#{@property_name}' must be a positive integer or a string representation of one."
      end
    end
  end
end
