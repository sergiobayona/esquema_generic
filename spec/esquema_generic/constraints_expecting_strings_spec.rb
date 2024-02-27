require 'spec_helper'
require 'esquema_generic/type_validator'

RSpec.describe EsquemaGeneric::TypeValidator, 'Constraint validation' do # rubocop:disable Metrics/BlockLength
  context 'with valid values' do # rubocop:disable Metrics/BlockLength
    it 'does not raise an error' do
      expect { described_class.validate!('property_name', 'string', { format: 'email' }) }.not_to raise_error
    end

    it 'does not raise an error' do
      expect { described_class.validate!('property_name', 'string', { pattern: 'pattern' }) }.not_to raise_error
    end

    it 'does not raise an error' do
      expect { described_class.validate!('property_name', 'string', { pattern: '^[a-zA-Z]+$' }) }.not_to raise_error
    end

    it 'does not raise an error' do
      expect { described_class.validate!('property_name', 'string', { title: 'title' }) }.not_to raise_error
    end

    it 'does not raise an error' do
      expect { described_class.validate!('property_name', 'string', { description: 'description' }) }.not_to raise_error
    end

    it 'does not raise an error' do
      expect { described_class.validate!('property_name', 'string', { description: '1' }) }.not_to raise_error
    end

    context 'with invalid values' do
      it 'raises an error' do
        expect { described_class.validate!('property_name', 'string', { format: 1 }) }
          .to raise_error(ArgumentError,
                          "Value of 'format' in 'property_name' must be a string.")
      end

      it 'raises an error' do
        expect { described_class.validate!('property_name', 'string', { pattern: 1 }) }
          .to raise_error(ArgumentError,
                          "Value of 'pattern' in 'property_name' must be a string.")
      end

      it 'raises an error' do
        expect { described_class.validate!('property_name', 'string', { title: 1 }) }
          .to raise_error(ArgumentError,
                          "Value of 'title' in 'property_name' must be a string.")
      end

      it 'raises an error' do
        expect { described_class.validate!('property_name', 'string', { description: 1 }) }
          .to raise_error(ArgumentError,
                          "Value of 'description' in 'property_name' must be a string.")
      end
    end
  end
end
