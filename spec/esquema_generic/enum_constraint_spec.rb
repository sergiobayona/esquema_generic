require "spec_helper"
require "esquema_generic/schema_validation"

RSpec.describe EsquemaGeneric::TypeValidator, "Enum validation" do
  context "with string type" do
    it "does not raise an error" do
      expect { described_class.validate!("property_name", "string", { enum: %w[email phone] }) }.not_to raise_error
    end

    it "does not raise an error" do
      expect { described_class.validate!("property_name", "string", { enum: %w[1 2 3] }) }.not_to raise_error
    end

    it "raises an error" do
      expect do
        described_class.validate!("property_name", "string",
                                  { enum: [1, 2, 3] })
      end.to raise_error(ArgumentError, "Value of 'enum' in 'property_name' must be an array of strings")
    end

    it "raises an error" do
      expect do
        described_class.validate!("property_name", "string",
                                  { enum: [nil, "1"] })
      end.to raise_error(ArgumentError, "Value of 'enum' in 'property_name' must be an array of strings")
    end
  end

  context "with integer type" do
    it "does not raise an error" do
      expect { described_class.validate!("property_name", "integer", { enum: [1, 2, 3] }) }.not_to raise_error
    end

    it "raises an error" do
      expect do
        described_class.validate!("property_name", "integer",
                                  { enum: %w[1 2 3] })
      end.to raise_error(ArgumentError, "Value of 'enum' in 'property_name' must be an array of integers")
    end

    it "raises an error" do
      expect do
        described_class.validate!("property_name", "integer",
                                  { enum: [nil, 1] })
      end.to raise_error(ArgumentError, "Value of 'enum' in 'property_name' must be an array of integers")
    end
  end

  context "with number type" do
    it "does not raise an error" do
      expect { described_class.validate!("property_name", "number", { enum: [1.1, 2.2, 3.3] }) }.not_to raise_error
    end

    it "raises an error" do
      expect do
        described_class.validate!("property_name", "number",
                                  { enum: %w[1 2 3] })
      end.to raise_error(ArgumentError, "Value of 'enum' in 'property_name' must be an array of numbers")
    end

    it "raises an error" do
      expect do
        described_class.validate!("property_name", "number",
                                  { enum: [nil, 1.1] })
      end.to raise_error(ArgumentError, "Value of 'enum' in 'property_name' must be an array of numbers")
    end
  end

  context "with boolean type" do
    it "does not raise an error" do
      expect { described_class.validate!("property_name", "boolean", { enum: [true, false] }) }.not_to raise_error
    end

    it "raises an error" do
      expect do
        described_class.validate!("property_name", "boolean",
                                  { enum: %w[true false] })
      end.to raise_error(ArgumentError, "Value of 'enum' in 'property_name' must be an array of booleans")
    end

    it "raises an error" do
      expect do
        described_class.validate!("property_name", "boolean",
                                  { enum: [nil, true] })
      end.to raise_error(ArgumentError, "Value of 'enum' in 'property_name' must be an array of booleans")
    end
  end

  context "with array type" do
    it "does not raise an error" do
      expect { described_class.validate!("property_name", "array", { enum: [%w[1 2], %w[3 4]] }) }.not_to raise_error
    end

    it "does not raise an error" do
      expect do
        described_class.validate!("property_name", "array", { enum: [%w[one two], %w[three four]] })
      end.not_to raise_error
    end

    it "raises an error" do
      expect do
        described_class.validate!("property_name", "array",
                                  { enum: %w[1 2 3] })
      end.to raise_error(ArgumentError, "Value of 'enum' in 'property_name' must be an array of arrays")
    end

    it "raises an error" do
      expect do
        described_class.validate!("property_name", "array",
                                  { enum: [nil, %w[1 2]] })
      end.to raise_error(ArgumentError, "Value of 'enum' in 'property_name' must be an array of arrays")
    end
  end

  context "with object type" do
    it "does not raise an error" do
      expect do
        described_class.validate!("property_name", "object", { enum: [{ one: 1 }, { two: 2 }] })
      end.not_to raise_error
    end

    it "does not raise an error" do
      expect do
        described_class.validate!("property_name", "object", { enum: [{ one: 1 }, { two: 2 }] })
      end.not_to raise_error
    end

    it "raises an error" do
      expect do
        described_class.validate!("property_name", "object",
                                  { enum: %w[1 2 3] })
      end.to raise_error(ArgumentError, "Value of 'enum' in 'property_name' must be an array of objects")
    end

    it "raises an error" do
      expect do
        described_class.validate!("property_name", "object",
                                  { enum: [nil, { one: 1 }] })
      end.to raise_error(ArgumentError, "Value of 'enum' in 'property_name' must be an array of objects")
    end
  end
end
