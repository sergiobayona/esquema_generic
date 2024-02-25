require 'spec_helper'
require 'esquema_generic/type_validator'

RSpec.describe EsquemaGeneric::TypeValidator do # rubocop:disable Metrics/BlockLength
  context 'with valid types' do # rubocop:disable Metrics/BlockLength
    it 'does not raise an error' do
      described_class::SUPPORTED_TYPES.each do |type|
        expect { described_class.validate!('property_name', type, {}) }.not_to raise_error
      end
    end

    context 'with invalid types' do # rubocop:disable Metrics/BlockLength
      it 'raises an error' do
        expect { described_class.validate!('property_name', 'invalid_type', {}) }
          .to raise_error(ArgumentError, "Unsupported type(s) 'invalid_type' for 'property_name'")
      end

      it 'raises an error' do
        expect { described_class.validate!('property_name', 1, nil) }
          .to raise_error(ArgumentError, "Unsupported type(s) '1' for 'property_name'")
      end

      it 'raises an error' do
        expect { described_class.validate!('property_name', [1], nil) }
          .to raise_error(ArgumentError, "Unsupported type(s) '1' for 'property_name'")
      end

      it 'raises an error' do
        expect { described_class.validate!('property_name', '', nil) }
          .to raise_error(ArgumentError, "Unsupported type(s) '' for 'property_name'")
      end

      it 'raises an error' do
        expect { described_class.validate!('property_name', true, nil) }
          .to raise_error(ArgumentError, "Unsupported type(s) 'true' for 'property_name'")
      end

      it 'raises an error' do
        expect { described_class.validate!('property_name', false, nil) }
          .to raise_error(ArgumentError, "Unsupported type(s) 'false' for 'property_name'")
      end

      it 'raise an error' do
        expect { described_class.validate!('property_name', nil, nil) }
          .to raise_error(ArgumentError, "Invalid type for 'property_name'")
      end

      it 'raises an error' do
        expect { described_class.validate!('property_name', {}, nil) }
          .to raise_error(ArgumentError, "Invalid type for 'property_name'")
      end

      it 'raises an error' do
        expect { described_class.validate!('property_name', [], nil) }
          .to raise_error(ArgumentError, "Invalid type for 'property_name'")
      end
    end

    context 'with multiple types' do
      it 'does not raise an error' do
        expect { described_class.validate!('property_name', %w[string integer], nil) }
          .not_to raise_error
      end

      it 'does not raise an error' do
        expect { described_class.validate!('property_name', %w[string null], {}) }
          .not_to raise_error
      end
    end
  end
end
