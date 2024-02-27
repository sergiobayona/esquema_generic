require_relative 'base_validator'

module EsquemaGeneric
  module Validators
    class AllofValidator < BaseValidator
      def validate
        raise ArgumentError, "Value for 'required' in '#{@property_name}' must be an array" unless @value.is_a?(Array)

        @value.each do |value|
          unless value.is_a?(Hash)
            raise ArgumentError,
                  "Value of 'allOf' in '#{@property_name}' must be an array of hashes"
          end
        end
      end
    end
  end
end
