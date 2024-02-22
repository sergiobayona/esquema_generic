# frozen_string_literal: true

module EsquemaGeneric
  # The Schema class is responsible for defining the schema of a class.
  class SchemaDefinition
    attr_reader :klass

    def initialize(klass, schema_definition)
      @schema_definition = schema_definition
      @klass = klass
    end

    # Sets the description for the schema document.
    #
    # @param description [String] The description of the schema document.
    def description(description)
      @schema_definition[:description] = description
    end

    # Sets the title of the schema document.
    #
    # @param title [String] The title of the schema document.
    def title(title)
      @schema_definition[:title] = title
    end

    # Adds a property to the schema.
    #
    # @param name [Symbol] The name of the property.
    # @param options [Hash] Additional options for the property.
    def property(name, options = {})
      @schema_definition[:properties] ||= {}
      @schema_definition[:properties][name] = options
    end
  end
end
