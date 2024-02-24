require_relative 'base_validator'

module EsquemaGeneric
  module Validators
    class IntegerValidator < BaseValidator
      # valid options are: 1, "1", any integer, or any integer wrapped in a string.
      # invalid options are: 1.5, "1.5", %w[1 2] or anything that's not an integer or an integer wrapped in a string.
      def validate
        unless @value.is_a?(Integer) || (@value.is_a?(String) && @value.to_i.to_s == @value)
          raise ArgumentError,
                "Value for '#{@constraint}' in '#{@property_name}' must be a string representing an integer or an integer."
        end

        @value = @value.to_s
      end
    end
  end
end
