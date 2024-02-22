# frozen_string_literal: true

require 'spec_helper'

RSpec.describe EsquemaGeneric::Model do
  let(:user) do
    Class.new do
      include EsquemaGeneric::Model
    end
  end

  describe '.schema_definition' do
    it 'returns the schema definition' do
      expect(user.schema_definition).to eq({})
    end
  end

  describe '.define_schema' do
    it 'enhances the schema using the provided block' do
      user.define_schema do
        property :name, title: "Person's Name"
        property :email, title: "Person's Mailing Address"
      end

      expect(user.schema_definition).to eq(
        properties: {
          name: { title: "Person's Name" },
          email: { title: "Person's Mailing Address" }
        }
      )
    end
  end
end
