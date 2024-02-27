require "spec_helper"
require "esquema_generic/schema_validation"

RSpec.describe EsquemaGeneric::TypeValidator, "Constraint validation" do
  context "with string type" do
    it "does not raise an error" do
      expect { described_class.validate!("property_name", "string", {}) }.not_to raise_error
    end

    it "does not raise an error" do
      expect { described_class.validate!("property_name", "string", { maxLength: 10 }) }.not_to raise_error
    end

    it "does not raise an error" do
      expect { described_class.validate!("property_name", "string", { maxLength: "10" }) }.not_to raise_error
    end

    it "raises an error" do
      expect { described_class.validate!("property_name", "string", { maxLength: %w[1 2] }) }
        .to raise_error(ArgumentError,
                        "Value of 'maxLength' in 'property_name' must be a positive integer or a string representation of one.")
    end

    it "raises an error" do
      expect { described_class.validate!("property_name", "string", { maxLength: 1.5 }) }
        .to raise_error(ArgumentError,
                        "Value of 'maxLength' in 'property_name' must be a positive integer or a string representation of one.")
    end

    it "raises an error" do
      expect { described_class.validate!("property_name", "string", { maxLength: "1.5" }) }
        .to raise_error(ArgumentError,
                        "Value of 'maxLength' in 'property_name' must be a positive integer or a string representation of one.")
    end

    it "raises an error" do
      expect { described_class.validate!("property_name", "string", { maxLength: -1 }) }
        .to raise_error(ArgumentError,
                        "Value of 'maxLength' in 'property_name' must be a positive integer or a string representation of one.")
    end

    it "raises an error" do
      expect { described_class.validate!("property_name", "string", { maxLength: "-1" }) }
        .to raise_error(ArgumentError,
                        "Value of 'maxLength' in 'property_name' must be a positive integer or a string representation of one.")
    end

    it "raises an error" do
      expect { described_class.validate!("property_name", "string", { maxLength: nil }) }
        .to raise_error(ArgumentError,
                        "Value of 'maxLength' in 'property_name' must be a positive integer or a string representation of one.")
    end

    it "raises an error" do
      expect { described_class.validate!("property_name", "string", { maxLength: "null" }) }
        .to raise_error(ArgumentError,
                        "Value of 'maxLength' in 'property_name' must be a positive integer or a string representation of one.")
    end

    it "raises an error" do
      expect { described_class.validate!("property_name", "string", { maxLength: Object }) }
        .to raise_error(ArgumentError,
                        "Value of 'maxLength' in 'property_name' must be a positive integer or a string representation of one.")
    end

    it "raises an error" do
      expect { described_class.validate!("property_name", "string", { maxLength: [] }) }
        .to raise_error(ArgumentError,
                        "Value of 'maxLength' in 'property_name' must be a positive integer or a string representation of one.")
    end

    it "raises an error" do
      expect { described_class.validate!("property_name", "string", { maxLength: {} }) }
        .to raise_error(ArgumentError,
                        "Value of 'maxLength' in 'property_name' must be a positive integer or a string representation of one.")
    end

    it "raises an error" do
      expect { described_class.validate!("property_name", "string", { maxLength: true }) }
        .to raise_error(ArgumentError,
                        "Value of 'maxLength' in 'property_name' must be a positive integer or a string representation of one.")
    end

    it "raises an error" do
      expect { described_class.validate!("property_name", "string", { maxLength: "" }) }
        .to raise_error(ArgumentError,
                        "Value of 'maxLength' in 'property_name' must be a positive integer or a string representation of one.")
    end

    it "raises an error" do
      expect { described_class.validate!("property_name", "string", { maxLength: "Integer(1)" }) }
        .to raise_error(ArgumentError,
                        "Value of 'maxLength' in 'property_name' must be a positive integer or a string representation of one.")
    end
  end
end
