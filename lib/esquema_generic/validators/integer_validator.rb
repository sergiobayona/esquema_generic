require_relative 'base_validator'

module EsquemaGeneric
  module Validators
    class StringValidator < BaseValidator
      def validate
        return if @value.is_a?(String)

        raise ArgumentError, "Value for #{@property_name} must be a string"
      end
    end
  end
end
