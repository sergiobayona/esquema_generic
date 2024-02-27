require 'pry-byebug'
module EsquemaGeneric
  class SchemaDefinition
    attr_reader :klass

    SCHEMA_KEYWORDS = {
      _schema: :_schema,
      _id: :_id,
      description: :description,
      type: :type,
      title: :title,
      all_of: :allOf,
      any_of: :anyOf,
      one_of: :oneOf,
      property: :property,
      required: :required,
      items: :items,
      additional_items: :additionalItems,
      pattern_properties: :patternProperties,
      additional_properties: :additionalProperties,
      dependencies: :dependencies,
      dependent_required: :dependentRequired,
      format: :format,
      content_media_type: :contentMediaType,
      content_encoding: :contentEncoding,
      schema_if: :if,
      schema_then: :then,
      schema_else: :else,
      schema_not: :not,
      enum: :enum,
      const: :const,
      default: :default,
      examples: :examples,
      max_length: :maxLength,
      min_length: :minLength,
      pattern: :pattern,
      maximum: :maximum,
      exclusive_maximum: :exclusiveMaximum,
      minimum: :minimum,
      exclusive_minimum: :exclusiveMinimum,
      multiple_of: :multipleOf,
      max_items: :maxItems,
      min_items: :minItems,
      unique_items: :uniqueItems,
      max_properties: :maxProperties,
      min_properties: :minProperties
    }.freeze

    def initialize(klass, schema_definition)
      @schema_definition = schema_definition
      @klass = klass
    end

    SCHEMA_KEYWORDS.each do |method_name, keyword|
      define_method(method_name) do |*values|
        @schema_definition[keyword] = values.size > 1 ? values : values.first
      end
    end

    def property(name, options = {})
      @schema_definition[:properties] ||= {}
      @schema_definition[:properties].merge!(name => options)
    end
  end
end
