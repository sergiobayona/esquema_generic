# frozen_string_literal: true

require 'json'
require 'active_support/time'
require 'active_support/concern'
require 'active_support/json'
require_relative 'builder'
require_relative 'schema_definition'

module EsquemaGeneric
  module Model
    extend ActiveSupport::Concern

    included do
      def self.json_schema
        @json_schema ||= {}
      end

      # Define the schema using the provided block.
      def self.define_schema(&block)
        schema_definition
        definition = SchemaDefinition.new(self, @schema_definition)
        definition.instance_eval(&block)
        @json_schema = Builder.build_schema(schema_definition)
      end

      # Returns the schema definition.
      def self.schema_definition
        @schema_definition ||= {}
      end
    end
  end
end
