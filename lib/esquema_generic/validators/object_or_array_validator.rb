require_relative 'base_validator'

module EsquemaGeneric
  module Validators
    class ObjectOrArrayValidator < BaseValidator
      def validate
        return if @value.is_a?(Array) || @value.is_a?(Hash)

        raise ArgumentError, "Value for #{@property_name} must be an object or an array"
      end
    end
  end
end
