module EsquemaGeneric
  module Validators
    class BaseValidator
      ITEM_TYPE_VALIDATORS = {
        string: ->(value) { value.is_a?(String) },
        integer: ->(value) { value.is_a?(Integer) },
        number: ->(value) { value.is_a?(Numeric) },
        boolean: ->(value) { [true, false].include?(value) },
        array: ->(value) { value.is_a?(Array) },
        object: ->(value) { value.is_a?(Hash) },
        null: ->(value) { value.nil? },
        date: ->(value) { value.is_a?(Date) },
        datetime: ->(value) { value.is_a?(DateTime) },
        time: ->(value) { value.is_a?(Time) }
      }.freeze

      def initialize(property_name, constraint, value, type)
        @property_name = property_name
        @constraint = constraint
        @value = value
        @type = type
      end

      def validate
        raise NotImplementedError, "#{self.class.name}#validate must be implemented"
      end
    end
  end
end
