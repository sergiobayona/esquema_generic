# frozen_string_literal: true

require_relative 'property'
require_relative 'schema_validation'

module EsquemaGeneric
  # The Builder class is responsible for building a schema for a class.
  class Builder
    OBJECT_KEYWORDS = %i[title description type properties required].freeze

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
      properties.each_with_object({}) do |(property_name, options), hash|
        TypeValidator.validate!(property_name, options[:type], options)
        hash[property_name] = Property.new(property_name, options)
      end
    end

    def properties
      @schema_definition[:properties] || {}
    end

    def build_required
      []
    end
  end
end
