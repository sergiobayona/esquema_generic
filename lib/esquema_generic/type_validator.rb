require 'esquema_generic/validators/integer_validator'
require 'esquema_generic/validators/string_validator'

module EsquemaGeneric
  module TypeValidator
    SUPPORTED_TYPES = %w[date datetime time string integer number boolean array object null].freeze

    # These are constraints supported for each property type.
    NUMERIC_CONSTRAINTS = %i[minimum maximum exclusiveMinimum exclusiveMaximum multipleOf].freeze
    STRING_CONSTRAINTS = %i[maxLength minLength pattern format].freeze
    ARRAY_CONSTRAINTS = %i[maxItems minItems uniqueItems items].freeze
    OBJECT_CONSTRAINTS = %i[required maxProperties minProperties properties patternProperties additionalProperties
                            dependencies propertyNames].freeze

    # These are constraints supported for all types.
    GENERIC_KEYWORDS = %i[type default title description enum const].freeze

    # These are constraints that are expected to have a particular value type regardless of the property type.
    STRING_EXPECTED_CONSTRAINT = %i[type format pattern title description _id _ref propertyNames].freeze
    INTEGER_EXPECTED_CONTRAINT = %i[minimum maximum exclusiveMinimum exclusiveMaximum multipleOf maxLength minLength
                                    maxItems minItems maxProperties minProperties].freeze
    OBJECT_OR_ARRAY_EXPECTED_CONSTRAINT = %i[enum items required allOf anyOf oneOf not dependencies definitions
                                             properties].freeze

    TYPE_CONSTRAINTS = {
      'string' => STRING_CONSTRAINTS,
      'integer' => NUMERIC_CONSTRAINTS,
      'number' => NUMERIC_CONSTRAINTS,
      'array' => ARRAY_CONSTRAINTS,
      'object' => OBJECT_CONSTRAINTS
    }.freeze

    class << self
      def validate!(property_name, type, constraints)
        validate_type(property_name, type)
        return if constraints.nil?

        validate_constraints(property_name, type, constraints)
      end

      private

      def validate_type(property_name, types)
        raise ArgumentError, "Invalid type for '#{property_name}'" if [nil, {}, []].include?(types)

        types = Array(types)
        unsupported_types = types - SUPPORTED_TYPES

        return if unsupported_types.empty?

        raise ArgumentError, "Unsupported type(s) '#{unsupported_types.join(', ')}' for '#{property_name}'"
      end

      def validate_constraints(property_name, types, constraints) # rubocop:disable Metrics/MethodLength
        types = Array(types) # Ensure types is always an array

        constraints.each do |constraint, value|
          applicable_types = types.select { |type| type_constraint_applicable?(type, constraint) }
          if applicable_types.empty?
            raise ArgumentError,
                  "Constraint '#{constraint}' is not applicable to any of the types #{types.join(', ')} for '#{property_name}'"
          end

          applicable_types.each do |type|
            validate_with_validator(property_name, type, constraint, value)
          end
        end
      end

      def type_constraint_applicable?(type, constraint)
        TYPE_CONSTRAINTS[type]&.include?(constraint) || GENERIC_KEYWORDS.include?(constraint)
      end

      def validate_with_validator(property_name, type, constraint, value)
        validator_class = validator_for(constraint, type) # Now also pass type
        if validator_class
          validator_class.new(property_name, constraint, value).validate
        else
          raise ArgumentError,
                "No validator found for constraint '#{constraint}' on property '#{property_name}' with type '#{type}'"
        end
      end

      def validator_for(constraint, type)
        case constraint
        when *INTEGER_EXPECTED_CONTRAINT
          type == 'integer' ? Validators::IntegerValidator : nil
        when *STRING_EXPECTED_CONSTRAINT
          type == 'string' ? Validators::StringValidator : nil
          # Adjust logic as needed based on actual constraint-type relationships
        end
      end
    end
  end
end
