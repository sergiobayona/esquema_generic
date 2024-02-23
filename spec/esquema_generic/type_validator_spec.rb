require 'spec_helper'
require 'esquema_generic/type_validator'

RSpec.describe EsquemaGeneric::TypeValidator do # rubocop:disable Metrics/BlockLength
  describe '.validate!' do # rubocop:disable Metrics/BlockLength
    context 'when the type is supported' do
      it 'does not raise an error' do
        expect { described_class.validate!('property_name', 'string', {}) }.not_to raise_error
      end

      it 'raises an error for unsupported constraints' do
        expect { described_class.validate!('property_name', 'string', { unsupported: true }) }
          .to raise_error(ArgumentError, "Unsupported keyword 'unsupported' for type 'string' in property_name")
      end
    end

    context 'when the type is not supported' do
      it 'raises an error' do
        expect { described_class.validate!('property_name', 'invalid_type', {}) }
          .to raise_error(ArgumentError, "Unsupported type 'invalid_type' for `property_name`")
      end
    end

    context 'when the constraints are nil' do
      it 'does not raise an error' do
        expect { described_class.validate!('property_name', 'string', nil) }.not_to raise_error
      end
    end

    context 'when the constraints are empty' do
      it 'does not raise an error' do
        expect { described_class.validate!('property_name', 'string', {}) }.not_to raise_error
      end
    end

    context 'when the constraints are supported' do
      it 'does not raise an error' do
        expect { described_class.validate!('property_name', 'string', { maxLength: 10 }) }.not_to raise_error
      end
    end
  end
end
