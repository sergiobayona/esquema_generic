require_relative 'base_validator'

module EsquemaGeneric
  module Validators
    class EnumValidator < BaseValidator
      # Validates that the values of enum correspond to the property type.
      # For example, if the property type is string, then the values of enum must be strings.

      def validate
        raise ArgumentError, "Value for 'enum' in '#{@property_name}' must be an array" unless @value.is_a?(Array)

        validator = ITEM_TYPE_VALIDATORS[@type.to_sym]

        @value.each do |enum_value|
          unless validator.call(enum_value)
            raise ArgumentError, "Value of 'enum' in '#{@property_name}' must be an array of #{@type.to_s.pluralize}"
          end
        end
      end
    end
  end
end
