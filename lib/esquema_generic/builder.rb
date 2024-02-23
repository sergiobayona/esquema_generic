# frozen_string_literal: true

require_relative 'property'

module EsquemaGeneric
  # The Builder class is responsible for building a schema for a class.
  class Builder
    OBJECT_KEYWORDS = %i[title description type properties required additionalProperties patternProperties
                         maxProperties dependencies propertyNames definitions _defs _comment examples allOf
                         anyOf oneOf not].freeze

    def self.build_schema(schema_definition)
      builder = new(schema_definition)
      builder.schema
    end

    def initialize(schema_definition)
      @schema_definition = schema_definition
      @properties = {}
      @required = []
    end

    def schema
      @schema ||= object_schema
    end

    def object_schema
      OBJECT_KEYWORDS.each_with_object({}) do |keyword, hash|
        value = send("build_#{keyword}")
        next if value.blank?

        hash[keyword] = value
      end.compact.to_json
    end

    def build_title
      @schema_definition[:title]
    end

    def build_description
      @schema_definition[:description]
    end

    def build_type
      @schema_definition[:type] || 'object'
    end

    def build_properties
      # properties.transform_values do |property|
      #   property
      # end
      {}
    end

    def properties
      @schema_definition[:properties] || {}
    end

    def build_required
      []
    end

    def build_additionalProperties
      false
    end

    def build_patternProperties
      {}
    end

    def build_maxProperties
      nil
    end

    def build_dependencies
      {}
    end

    def build_propertyNames
      nil
    end

    def build_definitions
      {}
    end

    def build__defs; end

    def build__comment; end

    def build_examples
      []
    end

    def build_allOf
      []
    end

    def build_anyOf
      []
    end

    def build_oneOf
      []
    end

    def build_not
      nil
    end
  end
end
