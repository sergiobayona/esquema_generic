require 'json'
# frozen_string_literal: true

module EsquemaGeneric
  class Property
    attr_reader :name, :options

    def initialize(name, options = {})
      @name = name
      @options = options
    end

    def as_json(*_args)
      {
        type: options[:type],
        title: options[:title],
        format: options[:format]
      }.compact.as_json
    end
  end
end
