module EsquemaGeneric
  module TypeValidator
    SUPPORTED_TYPES = %w[date datetime time string integer number boolean array object null].freeze
    NUMERIC_CONSTRAINTS = %i[minimum maximum exclusiveMinimum exclusiveMaximum multipleOf].freeze
    STRING_CONSTRAINTS = %i[maxLength minLength pattern format].freeze
    ARRAY_CONSTRAINTS = %i[maxItems minItems uniqueItems items].freeze
    OBJECT_CONSTRAINTS = %i[required maxProperties minProperties properties patternProperties additionalProperties
                            dependencies propertyNames].freeze
    GENERIC_KEYWORDS = %i[type default title description enum const].freeze
    TYPE_CONSTRAINTS = {
      'string' => STRING_CONSTRAINTS,
      'integer' => NUMERIC_CONSTRAINTS,
      'number' => NUMERIC_CONSTRAINTS,
      'array' => ARRAY_CONSTRAINTS,
      'object' => OBJECT_CONSTRAINTS
    }.freeze

    class << self
      def validate!(property_name, type, constraints)
        raise ArgumentError, "Unsupported type '#{type}' for `#{property_name}`" unless SUPPORTED_TYPES.include?(type)
        return unless constraints

        validate_constraints(property_name, type, constraints)
        validate_constraint_values(property_name, constraints)
      end

      private

      def validate_constraints(property_name, type, constraints)
        type_constraints = TYPE_CONSTRAINTS[type]
        valid_constraints = type_constraints ? type_constraints + GENERIC_KEYWORDS : GENERIC_KEYWORDS
        constraints.each_key do |constraint|
          unless valid_constraints.include?(constraint)
            raise ArgumentError, "Unsupported keyword '#{constraint}' for type '#{type}' in `#{property_name}`"
          end
        end
      end

      def validate_constraint_values(property_name, constraints)
        constraints.each do |constraint, value|
          case constraint
          when *NUMERIC_CONSTRAINTS
            validate_numeric_constraint_value(property_name, constraint, value)
          when *STRING_CONSTRAINTS
            validate_string_constraint_value(property_name, constraint, value)
          when *ARRAY_CONSTRAINTS
            validate_array_constraint_value(property_name, constraint, value)
          when :enum
            validate_enum_constraint_value(property_name, value)
          end
        end
      end

      def validate_constraint_value(property_name, constraint, value, expected_types)
        is_valid = case expected_types
                   when Class
                     value.is_a?(expected_types)
                   when Array
                     expected_types.any? { |type| value.is_a?(type) }
                   when Regexp
                     value.is_a?(String) && value.match?(expected_types)
                   when Proc
                     expected_types.call(value)
                   else
                     false
                   end
        return if is_valid

        expected_type_desc = expected_types.is_a?(Array) ? expected_types.map(&:to_s).join(', ') : expected_types.to_s
        raise ArgumentError, "Value for '#{constraint}' in `#{property_name}` must be of type #{expected_type_desc}"
      end

      def validate_numeric_constraint_value(property_name, constraint, value)
        validate_constraint_value(property_name, constraint, value, Numeric)
      end

      def validate_string_constraint_value(property_name, constraint, value)
        case constraint
        when :pattern
          validate_constraint_value(property_name, constraint, value, Regexp)
        when :minLength, :maxLength
          validate_constraint_value(property_name, constraint, value, Integer)
        when :format
          validate_format_constraint_value(property_name, value)
        end
      end

      def validate_format_constraint_value(property_name, value)
        return if value.is_a?(String)

        raise ArgumentError, "Value for 'format' in `#{property_name}` must be a string"

        # Additional validation for specific formats can be implemented here
      end

      def validate_array_constraint_value(property_name, constraint, value)
        validate_constraint_value(property_name, constraint, value, Array)
      end

      def validate_enum_constraint_value(property_name, value)
        validate_constraint_value(property_name, :enum, value, Array)
      end
    end
  end
end
