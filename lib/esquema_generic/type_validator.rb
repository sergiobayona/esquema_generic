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

      def validate_type(property_name, type)
        raise ArgumentError, "Unsupported type '#{type}' for '#{property_name}'" unless SUPPORTED_TYPES.include?(type)
      end

      def validate_constraints(property_name, type, constraints)
        constraints.each do |constraint, value|
          validate_keyword(property_name, type, constraint)
          validate_with_validator(property_name, constraint, value)
        end
      end

      def validate_keyword(property_name, type, constraint)
        return if TYPE_CONSTRAINTS[type]&.include?(constraint) || GENERIC_KEYWORDS.include?(constraint)

        raise ArgumentError, "Unsupported keyword '#{constraint}' for type '#{type}' in '#{property_name}'"
      end

      def validate_with_validator(property_name, constraint, value)
        validator_class = validator_for(constraint)
        validator_class.new(property_name, constraint, value).validate if validator_class
      end

      def validator_for(constraint)
        case constraint
        when *INTEGER_EXPECTED_CONTRAINT
          Validators::IntegerValidator
        when *STRING_EXPECTED_CONSTRAINT
          Validators::StringValidator
        when *OBJECT_OR_ARRAY_EXPECTED_CONSTRAINT
          Validators::ObjectOrArrayValidator
        end
      end
    end
  end
end
