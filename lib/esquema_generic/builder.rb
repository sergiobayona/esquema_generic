# frozen_string_literal: true

require_relative 'property'

module EsquemaGeneric
  # The Builder class is responsible for building a schema for a class.
  class Builder
    attr_reader :klass

    def initialize(klass)
      @klass = klass
      @properties = {}
      @required_properties = []
    end
  end
end
