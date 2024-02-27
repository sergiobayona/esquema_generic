require_relative 'base_validator'

module EsquemaGeneric
  module Validators
    class RequiredValidator < BaseValidator
      def validate
        raise ArgumentError, "Value for 'required' in '#{@property_name}' must be an array" unless @value.is_a?(Array)

        @value.each do |value|
          unless value.is_a?(String)
            raise ArgumentError,
                  "Value of 'required' in '#{@property_name}' must be an array of strings"
          end
        end
      end
    end
  end
end
