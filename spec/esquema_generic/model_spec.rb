# frozen_string_literal: true

require 'spec_helper'

RSpec.describe EsquemaGeneric::Model do # rubocop:disable Metrics/BlockLength
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

  describe '.json_schema' do
    it 'returns the JSON schema' do
      expect(user.json_schema).to eq({})
    end
  end

  describe '.schema_definition' do
    it 'enhances the schema using the provided block' do
      user.define_schema do
        title 'User'
        description 'A user of the system'
        property :name, type: 'string', title: "Person's Name"
        property :email, type: 'string', format: 'email', title: "Person's Mailing Address"
      end

      properties = user.schema_definition[:properties]

      expect(properties).to be_a(Hash)
      expect(user.schema_definition[:title]).to eq('User')
      expect(user.schema_definition[:description]).to eq('A user of the system')
      expect(properties[:name]).to eq(type: 'string')
      expect(properties[:email]).to eq(type: 'string')
    end
  end

  describe '.json_schema' do
    it 'returns the JSON schema for the model' do
      user.define_schema do
        title 'User'
        description 'A user of the system'
        property :name, type: 'string', title: "Person's Name"
        property :email, type: 'string', format: 'email', title: "Person's Mailing Address"
      end

      expect(user.json_schema).to include_json({
                                                 title: 'User',
                                                 description: 'A user of the system',
                                                 type: 'object'
                                               })
    end
  end
end
