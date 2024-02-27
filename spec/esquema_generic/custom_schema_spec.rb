# frozen_string_literal: true

require 'spec_helper'

RSpec.describe EsquemaGeneric::Model do
  let(:custom_obj) do
    Class.new do
      include EsquemaGeneric::Model
    end
  end

  describe '.schema_definition' do
    it 'enhances the schema using the provided block' do
      custom_obj.define_schema do
        all_of [{ type: 'object', properties: { name: { type: 'string' } } }]
      end
    end
  end
end
