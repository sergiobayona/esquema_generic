require 'active_support/inflector'
require_relative 'validators/base_validator'
require_relative 'validators/integer_validator'
require_relative 'validators/string_validator'
require_relative 'validators/enum_validator'

module EsquemaGeneric
  module TypeValidator
    SUPPORTED_TYPES = %w[date datetime time string integer number boolean array object null].freeze

    # These are constraints supported for each property type.
    NUMERIC_TYPE_CONSTRAINTS = %i[minimum maximum exclusiveMinimum exclusiveMaximum multipleOf].freeze
    STRING_TYPE_CONSTRAINTS = %i[maxLength minLength pattern format].freeze
    ARRAY_TYPE_CONSTRAINTS = %i[maxItems minItems uniqueItems items].freeze
    OBJECT_TYPE_CONSTRAINTS = %i[required maxProperties minProperties properties patternProperties additionalProperties
                                 dependencies propertyNames].freeze

    # These are constraints supported for all types.
    GENERIC_KEYWORDS = %i[type default title description enum const].freeze

    # These are constraints grouped by the value type they are expected to have.
    STRING_EXPECTED_CONSTRAINT = %i[type format pattern title description _id _ref propertyNames].freeze
    INTEGER_EXPECTED_CONTRAINT = %i[minimum maximum exclusiveMinimum exclusiveMaximum multipleOf maxLength minLength
                                    maxItems minItems maxProperties minProperties].freeze
    ARRAY_EXPECTED_CONSTRAINT = []
    OBJECT_OR_ARRAY_EXPECTED_CONSTRAINT = %i[enum items required allOf anyOf oneOf not dependencies definitions
                                             properties].freeze
    TYPE_CONSTRAINTS = {
      'string' => STRING_TYPE_CONSTRAINTS,
      'integer' => NUMERIC_TYPE_CONSTRAINTS,
      'number' => NUMERIC_TYPE_CONSTRAINTS,
      'array' => ARRAY_TYPE_CONSTRAINTS,
      'object' => OBJECT_TYPE_CONSTRAINTS
    }.freeze

    class << self
      def validate!(property_name, type, constraints)
        type = Array(type)
        raise ArgumentError, "Unsupported type for property: '#{property_name}'" if type.empty?

        validate_type(property_name, type)
        return if constraints.nil?

        validate_constraints(property_name, type, constraints)
      end

      private

      def validate_type(property_name, types)
        unsupported_types = types - SUPPORTED_TYPES
        return if unsupported_types.empty?

        raise ArgumentError,
              "Unsupported type(s) '#{unsupported_types.join(', ')}' for '#{property_name}'"
      end

      def validate_constraints(property_name, types, constraints)
        constraints.each do |constraint, value|
          applicable_types = types.select { |_type| type_constraint_applicable?(types, constraint) }
          if applicable_types.empty?
            raise ArgumentError,
                  "Constraint '#{constraint}' is not applicable to type: #{types.join(', ')} for '#{property_name}'"
          end

          applicable_types.each { |type| validate_with_validator(property_name, constraint, value, type) }
        end
      end

      def type_constraint_applicable?(types, constraint)
        return true if GENERIC_KEYWORDS.include?(constraint)

        types.any? { |type| TYPE_CONSTRAINTS[type]&.include?(constraint) }
      end

      def validate_with_validator(property_name, constraint, value, type)
        validator_class = validator_for(constraint)
        if validator_class.nil?
          raise ArgumentError,
                "No validator class found for constraint '#{constraint}' in '#{property_name}'"
        end

        validator_class.new(property_name, constraint, value, type).validate if validator_class
      end

      def validator_for(constraint)
        case constraint
        when *INTEGER_EXPECTED_CONTRAINT
          Validators::IntegerValidator
        when *STRING_EXPECTED_CONSTRAINT
          Validators::StringValidator
        else
          validator = "EsquemaGeneric::Validators::#{constraint.capitalize}Validator"
          validator.safe_constantize
        end
      end
    end
  end
end
