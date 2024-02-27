require "spec_helper"
require "esquema_generic/schema_validation"

RSpec.describe EsquemaGeneric::TypeValidator do
  # describe '.validate!' do
  #   context 'when the type is supported' do
  #     it 'does not raise an error' do
  #       expect { described_class.validate!('property_name', 'string', {}) }.not_to raise_error
  #     end
  #   end

  #   it 'raises an error for unsupported constraints' do
  #     expect { described_class.validate!('property_name', 'string', { unsupported: true }) }
  #       .to raise_error(ArgumentError, "Constraint 'unsupported' is not applicable to type: string for 'property_name'")
  #   end

  #   context 'when the type is not supported' do
  #     it 'raises an error' do
  #       expect { described_class.validate!('property_name', 'invalid_type', {}) }
  #         .to raise_error(ArgumentError, "Unsupported type(s) 'invalid_type' for 'property_name'")
  #     end
  #   end

  #   context 'when the constraints are nil' do
  #     it 'does not raise an error' do
  #       expect { described_class.validate!('property_name', 'string', nil) }.not_to raise_error
  #     end
  #   end

  #   context 'when the constraints are empty' do
  #     it 'does not raise an error' do
  #       expect { described_class.validate!('property_name', 'string', {}) }.not_to raise_error
  #     end
  #   end

  #   context 'when the constraints are supported' do
  #     it 'does not raise an error' do
  #       expect { described_class.validate!('property_name', 'string', { maxLength: 10 }) }.not_to raise_error
  #     end

  #     it 'does not raise an error' do
  #       expect { described_class.validate!('property_name', 'string', { maxLength: '10' }) }.not_to raise_error
  #     end
  #   end

  #   context 'when the constraints values are not supported' do
  #     it 'raises an error' do
  #       expect { described_class.validate!('first_name', 'string', { maxLength: %w[1 2] }) }
  #         .to raise_error(ArgumentError,
  #                         "Value for 'maxLength' in 'first_name' must be a string representing an integer or an integer.")
  #     end

  #     it 'raises an error' do
  #       expect { described_class.validate!('first_name', 'string', { maxLength: 1.5 }) }
  #         .to raise_error(ArgumentError,
  #                         "Value for 'maxLength' in 'first_name' must be a string representing an integer or an integer.")
  #     end

  #     it 'raises an error' do
  #       expect { described_class.validate!('first_name', 'string', { maxLength: '1.5' }) }
  #         .to raise_error(ArgumentError,
  #                         "Value for 'maxLength' in 'first_name' must be a string representing an integer or an integer.")
  #     end

  #     it 'raises an error' do
  #       expect { described_class.validate!('first_name', 'string', { maxLength: nil }) }
  #         .to raise_error(ArgumentError,
  #                         "Value for 'maxLength' in 'first_name' must be a string representing an integer or an integer.")
  #     end

  #     it 'raises an error' do
  #       expect { described_class.validate!('first_name', 'string', { maxLength: true }) }
  #         .to raise_error(ArgumentError,
  #                         "Value for 'maxLength' in 'first_name' must be a string representing an integer or an integer.")
  #     end

  #     it 'raises an error' do
  #       expect { described_class.validate!('first_name', 'string', { maxLength: {} }) }
  #         .to raise_error(ArgumentError,
  #                         "Value for 'maxLength' in 'first_name' must be a string representing an integer or an integer.")
  #     end
  #   end

  #   context "when the constraints values are supported for 'string' type" do
  #     it 'does not raise an error' do
  #       expect { described_class.validate!('property_name', 'string', { pattern: '^[a-z]+$' }) }.not_to raise_error
  #     end

  #     it 'does not raise an error' do
  #       expect { described_class.validate!('property_name', 'string', { format: 'email' }) }.not_to raise_error
  #     end

  #     it 'does not raise an error' do
  #       expect { described_class.validate!('property_name', 'string', { minLength: 1 }) }.not_to raise_error
  #     end

  #     it 'does not raise an error' do
  #       expect { described_class.validate!('property_name', 'string', { maxLength: 10 }) }.not_to raise_error
  #     end
  #   end

  #   context 'when the constraints are not supported for string type' do
  #     it 'raises an error' do
  #       expect { described_class.validate!('property_name', 'string', { minimum: 1 }) }
  #         .to raise_error(ArgumentError, "Constraint 'minimum' is not applicable to type: 'string' for 'property_name'")
  #     end

  #     it 'raises an error' do
  #       expect { described_class.validate!('property_name', 'string', { maximum: 10 }) }
  #         .to raise_error(ArgumentError, "Constraint 'maximum' is not applicable to type: 'string' for 'property_name'")
  #     end

  #     it 'raises an error' do
  #       expect { described_class.validate!('property_name', 'string', { exclusiveMinimum: true }) }
  #         .to raise_error(ArgumentError,
  #                         "Constraint 'exclusiveMinimum' is not applicable to type: 'string' for 'property_name'")
  #     end

  #     it 'raises an error' do
  #       expect { described_class.validate!('property_name', 'string', { exclusiveMaximum: true }) }
  #         .to raise_error(ArgumentError,
  #                         "Constraint 'exclusiveMaximum' is not applicable to type: 'string' for 'property_name'")
  #     end
  #   end

  #   context 'when the constraints are not supported for integer type' do
  #     it 'does not raise an error' do
  #       expect { described_class.validate!('property_name', 'integer', { minimum: 1 }) }.not_to raise_error
  #     end

  #     it 'does not raise an error' do
  #       expect { described_class.validate!('property_name', 'integer', { maximum: 10 }) }.not_to raise_error
  #     end
  #   end

  #   context "when the constraints values are not supported for 'integer' type" do
  #     it 'raises an error' do
  #       expect { described_class.validate!('property_name', 'integer', { exclusiveMinimum: true }) }.to raise_error
  #     end

  #     it 'raises an error' do
  #       expect { described_class.validate!('property_name', 'integer', { exclusiveMaximum: true }) }.to raise_error
  #     end

  #     it 'raises an error' do
  #       expect { described_class.validate!('property_name', 'integer', { multipleOf: 2 }) }.to raise_error
  #     end
  #   end
  # end
end
