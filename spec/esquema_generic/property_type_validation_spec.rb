require "spec_helper"
require "esquema_generic/schema_validation"

RSpec.describe EsquemaGeneric::TypeValidator do
  context "with valid types" do
    context "with 'null' type" do
      it "does not raise an error" do
        expect { described_class.validate!("property_name", "null", {}) }.not_to raise_error
      end
    end

    context "with 'object' type" do
      it "does not raise an error" do
        expect { described_class.validate!("property_name", "object", {}) }.not_to raise_error
      end
    end

    context "with 'array' type" do
      it "does not raise an error" do
        expect { described_class.validate!("property_name", "array", {}) }.not_to raise_error
      end
    end

    context "with 'string' type" do
      it "does not raise an error" do
        expect { described_class.validate!("property_name", "string", {}) }.not_to raise_error
      end
    end

    context "with 'integer' type" do
      it "does not raise an error" do
        expect { described_class.validate!("property_name", "integer", {}) }.not_to raise_error
      end
    end

    context "with 'number' type" do
      it "does not raise an error" do
        expect { described_class.validate!("property_name", "number", {}) }.not_to raise_error
      end
    end

    context "with boolean type" do
      it "does not raise an error" do
        expect { described_class.validate!("property_name", "boolean", {}) }.not_to raise_error
      end
    end

    context "with date type" do
      it "does not raise an error" do
        expect { described_class.validate!("property_name", "date", {}) }.not_to raise_error
      end
    end

    context "with datetime type" do
      it "does not raise an error" do
        expect { described_class.validate!("property_name", "datetime", {}) }.not_to raise_error
      end
    end

    context "with time type" do
      it "does not raise an error" do
        expect { described_class.validate!("property_name", "time", {}) }.not_to raise_error
      end
    end

    context "with multiple types" do
      it "does not raise an error" do
        expect { described_class.validate!("property_name", %w[string integer], nil) }
          .not_to raise_error
      end

      it "does not raise an error" do
        expect { described_class.validate!("property_name", %w[string null], {}) }
          .not_to raise_error
      end
    end

    context "with invalid types" do
      it "raises an error" do
        expect { described_class.validate!("property_name", "invalid_type", {}) }
          .to raise_error(ArgumentError, "Unsupported type(s) 'invalid_type' for 'property_name'")
      end

      it "raises an error" do
        expect { described_class.validate!("property_name", 1, nil) }
          .to raise_error(ArgumentError, "Unsupported type(s) '1' for 'property_name'")
      end

      it "raises an error" do
        expect { described_class.validate!("property_name", [1], nil) }
          .to raise_error(ArgumentError, "Unsupported type(s) '1' for 'property_name'")
      end

      it "raises an error" do
        expect { described_class.validate!("property_name", "", nil) }
          .to raise_error(ArgumentError, "Unsupported type(s) '' for 'property_name'")
      end

      it "raises an error" do
        expect { described_class.validate!("property_name", true, nil) }
          .to raise_error(ArgumentError, "Unsupported type(s) 'true' for 'property_name'")
      end

      it "raises an error" do
        expect { described_class.validate!("property_name", false, nil) }
          .to raise_error(ArgumentError, "Unsupported type(s) 'false' for 'property_name'")
      end

      context "with argument types that lead to an empty array" do
        it "raises an error" do
          expect { described_class.validate!("property_name", [], {}) }
            .to raise_error(ArgumentError, "Unsupported type for property: 'property_name'")
        end

        it "raises an error" do
          expect { described_class.validate!("property_name", {}, {}) }
            .to raise_error(ArgumentError, "Unsupported type for property: 'property_name'")
        end

        it "raises an error" do
          expect { described_class.validate!("property_name", nil, {}) }
            .to raise_error(ArgumentError, "Unsupported type for property: 'property_name'")
        end
      end
    end
  end
end
