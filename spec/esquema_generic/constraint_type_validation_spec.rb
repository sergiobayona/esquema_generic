require 'spec_helper'
require 'esquema_generic/type_validator'

RSpec.describe EsquemaGeneric::TypeValidator, 'Constraint validation' do # rubocop:disable Metrics/BlockLength
  context 'with string type' do
    it 'does not raise an error' do
      expect { described_class.validate!('property_name', 'string', {}) }.not_to raise_error
    end

    it 'does not raise an error' do
      expect { described_class.validate!('property_name', 'string', { maxLength: 10 }) }.not_to raise_error
    end

    it 'does not raise an error' do
      expect { described_class.validate!('property_name', 'string', { maxLength: '10' }) }.not_to raise_error
    end

    it 'raises an error' do
      expect { described_class.validate!('property_name', 'string', { maxLength: %w[1 2] }) }
        .to raise_error(ArgumentError,
                        "Value for 'maxLength' in 'property_name' must be a string representing an integer or an integer.")
    end

    it 'raises an error' do
      expect { described_class.validate!('property_name', 'string', { maxLength: 1.5 }) }
        .to raise_error(ArgumentError,
                        "Value for 'maxLength' in 'property_name' must be a string representing an integer or an integer.")
    end

    it 'raises an error' do
      expect { described_class.validate!('property_name', 'string', { maxLength: '1.5' }) }
        .to raise_error(ArgumentError,
                        "Value for 'maxLength' in 'property_name' must be a string representing an integer or an integer.")
    end
  end
end
