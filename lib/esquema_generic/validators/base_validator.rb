module EsquemaGeneric
  module Validators
    class BaseValidator
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
