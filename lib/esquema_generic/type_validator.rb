require 'esquema_generic/validators/integer_validator'
require 'esquema_generic/validators/string_validator'
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
        # Ensure the type is supported
        raise ArgumentError, "Unsupported type '#{type}' for '#{property_name}'" unless SUPPORTED_TYPES.include?(type)

        return if constraints.nil?

        # Validate each constraint keyword before delegating to specific validators
        constraints.each do |constraint, value|
          unless TYPE_CONSTRAINTS[type]&.include?(constraint) || GENERIC_KEYWORDS.include?(constraint)
            raise ArgumentError, "Unsupported keyword '#{constraint}' for type '#{type}' in '#{property_name}'"
          end

          # Delegate to the specific validator if the keyword is supported
          validator_class = validator_for(constraint)
          validator_class.new(property_name, value).validate if validator_class
        end
      end

      private

      def validator_for(constraint)
        # Example mapping, this should be expanded based on actual validation needs.
        case constraint
        when *NUMERIC_CONSTRAINTS
          Validators::IntegerValidator
        when *STRING_CONSTRAINTS
          Validators::StringValidator
        end
      end
    end
  end
end
