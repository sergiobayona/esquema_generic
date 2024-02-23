module EsquemaGeneric
  module TypeValidator
    SUPPORTED_TYPES = %w[date datetime time string integer number boolean array object null].freeze

    NUMERIC_CONSTRAINTS = %i[minimum maximum exclusiveMinimum exclusiveMaximum multipleOf].freeze
    STRING_CONSTRAINTS = %i[maxLength minLength pattern format].freeze
    ARRAY_CONSTRAINTS = %i[maxItems minItems uniqueItems items].freeze
    OBJECT_CONSTRAINTS = %i[required maxProperties minProperties properties patternProperties
                            additionalProperties dependencies propertyNames].freeze
    GENERIC_KEYWORDS = %i[type default title description enum const].freeze

    TYPE_CONSTRAINTS = {
      'string' => STRING_CONSTRAINTS,
      'integer' => NUMERIC_CONSTRAINTS,
      'number' => NUMERIC_CONSTRAINTS,
      'array' => ARRAY_CONSTRAINTS,
      'object' => OBJECT_CONSTRAINTS
    }.freeze

    class << self
      # Validates if the type and constraints of a property are supported
      def validate!(property_name, type, constraints)
        raise ArgumentError, "Unsupported type '#{type}' for `#{property_name}`" unless SUPPORTED_TYPES.include?(type)

        return unless constraints

        validate_constraints(property_name, type, constraints)
      end

      private

      # Validates the constraints for a given type
      def validate_constraints(property_name, type, constraints)
        type_constraints = TYPE_CONSTRAINTS[type]
        valid_constraints = type_constraints + GENERIC_KEYWORDS
        constraints.each_key do |constraint|
          unless valid_constraints.include?(constraint)
            raise ArgumentError, "Unsupported keyword '#{constraint}' for type '#{type}' in #{property_name}"
          end
        end
      end
    end
  end
end
