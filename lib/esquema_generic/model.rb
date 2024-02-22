# frozen_string_literal: true

require 'active_support/concern'
require_relative 'builder'
require_relative 'schema_definition'

module EsquemaGeneric
  module Model
    extend ActiveSupport::Concern

    included do
      # Returns the JSON schema for the model.
      def self.json_schema
        Builder.new(self).build_schema.to_json
      end

      # Define the schema using the provided block.
      def self.define_schema(&block)
        schema_definition
        definition = SchemaDefinition.new(self, @schema_definition)
        definition.instance_eval(&block)
      end

      # Returns the schema definition.
      def self.schema_definition
        @schema_definition ||= {}
      end
    end
  end
end
