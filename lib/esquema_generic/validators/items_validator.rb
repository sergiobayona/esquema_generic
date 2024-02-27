require_relative 'base_validator'

module EsquemaGeneric
  module Validators
    class ItemsValidator < BaseValidator
      def validate
        validate_value_type
        validate_value_empty
        validate_items
      end

      private

      def validate_value_type
        return if @value.is_a?(Array) || @value.is_a?(Hash)

        raise ArgumentError, "Value of 'items' in '#{@property_name}' must be an array or a hash."
      end

      def validate_value_empty
        return unless @value.empty?

        raise ArgumentError, "Value of 'items' in '#{@property_name}' is empty"
      end

      def validate_items
        items = @value.is_a?(Array) ? @value : [@value]
        items.each { |item| validate_item(item) }
      end

      def validate_item(item)
        return if item.is_a?(Hash) && item.keys.include?(:type)

        raise ArgumentError, "Elements in 'items' constraint must contain a type keyword."
      end
    end
  end
end
