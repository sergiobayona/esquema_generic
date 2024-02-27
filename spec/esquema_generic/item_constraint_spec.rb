require "spec_helper"
require "esquema_generic/schema_validation"

RSpec.describe EsquemaGeneric::TypeValidator, "Item validation" do
  context "with valid values" do
    it "does not raise an error" do
      expect { described_class.validate!("property_name", "array", { items: { type: "object" } }) }.not_to raise_error
    end

    it "does not raise an error" do
      expect { described_class.validate!("property_name", "array", { items: { type: "string" } }) }.not_to raise_error
    end

    it "does not raise an error" do
      expect do
        described_class.validate!("property_name", "array", { items: [{ type: "integer" }] })
      end.not_to raise_error
    end

    it "does not raise an error" do
      expect do
        described_class.validate!("property_name", "array", { items: { type: "integer" } })
      end.not_to raise_error
    end

    it "does not raise an error" do
      expect do
        described_class.validate!("property_name", "array", { items: { type: %w[string integer] } })
      end.not_to raise_error
    end

    it "does not raise an error" do
      expect do
        described_class.validate!("property_name", "array", { items: { type: [1, 2] } })
      end.not_to raise_error
    end
  end

  context "with type other than array" do
    it "raises an error" do
      expect do
        described_class.validate!("property_name", "string", { items: { type: "object" } })
      end.to raise_error(ArgumentError, "Constraint 'items' is not applicable to type: string for 'property_name'")
    end
  end

  context "with an array of strings" do
    it "raises an error" do
      expect do
        described_class.validate!("property_name", "array", { items: ["test"] })
      end.to raise_error(ArgumentError, "Elements in 'items' constraint must contain a type keyword.")
    end
  end

  context "with an array of hashes without type" do
    it "raises an error" do
      expect do
        described_class.validate!("property_name", "array", { items: [{ name: "somename" }] })
      end.to raise_error(ArgumentError, "Elements in 'items' constraint must contain a type keyword.")
    end
  end
end
