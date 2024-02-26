require_relative 'base_validator'

module EsquemaGeneric
  module Validators
    class ItemsValidator < BaseValidator
      # Validates that the values of items are an array or an object.
      def validate # rubocop:disable Metrics/CyclomaticComplexity,Metrics/MethodLength
        unless @value.is_a?(Array) || @value.is_a?(Hash)
          raise ArgumentError,
                "Value if 'items' in '#{@property_name}' must be an array or a hash."
        end

        raise ArgumentError, "Value of 'items' in '#{@property_name}' is empty" if @value.empty?

        validate_item(@value) if @value.is_a?(Hash)

        return unless @value.is_a?(Array)

        @value.each do |item|
          raise ArgumentError, 'Items constraint must contain hashes.' unless item.is_a?(Hash)

          validate_item(item)
        end
      end

      def validate_item(item)
        return if item.keys.include?(:type)

        raise ArgumentError,
              "Elements in 'items' constraint must contain a type keyword."
      end
    end
  end
end
