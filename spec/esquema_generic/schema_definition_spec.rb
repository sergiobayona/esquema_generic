require "spec_helper"
require "esquema_generic/schema_definition"

RSpec.describe EsquemaGeneric::SchemaDefinition do
  let(:klass) { double("Class") }
  let(:schema_definition) { {} }
  let(:schema) { described_class.new(klass, schema_definition) }

  it "can be initialized with a class and a schema definition" do
    expect(schema.klass).to eq(klass)
    expect(schema.instance_variable_get(:@schema_definition)).to eq(schema_definition)
  end

  it "can set schema keywords and properties with nil values" do
    described_class::SCHEMA_KEYWORDS.each do |method_name, keyword|
      schema.send(method_name, nil)
      expect(schema.instance_variable_get(:@schema_definition)[keyword]).to be_nil
    end

    schema.property("name", nil)
    expect(schema.instance_variable_get(:@schema_definition)[:properties]["name"]).to be_nil
  end

  context "when setting schema keywords and properties with values" do
    let(:user) do
      Class.new do
        include EsquemaGeneric::Model
      end
    end

    it "can set the _schema value" do
      user.define_schema { _schema "https://json-schema.org/draft/2020-12/schema" }

      expect(user.schema_definition[:_schema]).to eq("https://json-schema.org/draft/2020-12/schema")
    end

    it "can set _id value" do
      user.define_schema { _id "https://example.com/schemas/user" }
      expect(user.schema_definition[:_id]).to eq("https://example.com/schemas/user")
    end

    it "can set description value" do
      user.define_schema { description "Some description" }
      expect(user.schema_definition[:description]).to eq("Some description")
    end

    it "can set type value" do
      user.define_schema { type "object" }
      expect(user.schema_definition[:type]).to eq("object")
    end

    it "can set title value" do
      user.define_schema { title "User" }
      expect(user.schema_definition[:title]).to eq("User")
    end

    it "can set all_of value" do
      user.define_schema { all_of [{ type: "string" }] }
      expect(user.schema_definition[:allOf]).to eq([{ type: "string" }])
    end

    it "can set any_of value" do
      user.define_schema { any_of [{ type: "string" }] }
      expect(user.schema_definition[:anyOf]).to eq([{ type: "string" }])
    end

    it "can set one_of value" do
      user.define_schema { one_of [{ type: "string" }] }
      expect(user.schema_definition[:oneOf]).to eq([{ type: "string" }])
    end

    it "can set all_of value" do
      user.define_schema { all_of [{ type: "string" }] }
      expect(user.schema_definition[:allOf]).to eq([{ type: "string" }])
    end

    it "can set property value" do
      user.define_schema { property "name", type: "string" }
      expect(user.schema_definition[:properties]["name"]).to eq(type: "string")
    end

    it "can set required value" do
      user.define_schema { required ["name"] }
      expect(user.schema_definition[:required]).to eq(["name"])
    end

    it "can set items value" do
      user.define_schema { items type: "string" }
      expect(user.schema_definition[:items]).to eq(type: "string")
    end

    it "can set additional_items value" do
      user.define_schema { additional_items false }
      expect(user.schema_definition[:additionalItems]).to eq(false)
    end

    it "can set pattern_properties value" do
      user.define_schema { pattern_properties({ "^S_" => { "type": "string" } }) }
      expect(user.schema_definition[:patternProperties]).to eq("^S_" => { type: "string" })
    end

    it "can set additional_properties value" do
      user.define_schema { additional_properties false }
      expect(user.schema_definition[:additionalProperties]).to eq(false)
    end

    it "can set dependencies value" do
      user.define_schema do
        dependencies(
          {
            "credit_card": {
              "properties": {
                "billingAddress": { "type": "string" }
              }
            }
          }
        )
      end
      expect(user.schema_definition[:dependencies]).to eq(
        {
          credit_card: {
            properties: {
              billingAddress: {
                type: "string"
              }
            }
          }
        }
      )
    end

    it "can set dependent_required value" do
      user.define_schema do
        dependent_required({ "name" => "age" })
      end
      expect(user.schema_definition[:dependentRequired]).to eq("name" => "age")
    end

    it "can set format value" do
      user.define_schema { format "email" }
      expect(user.schema_definition[:format]).to eq("email")
    end

    it "can set content_media_type value" do
      user.define_schema { content_media_type "application/json" }
      expect(user.schema_definition[:contentMediaType]).to eq("application/json")
    end

    it "can set content_encoding value" do
      user.define_schema { content_encoding "base64" }
      expect(user.schema_definition[:contentEncoding]).to eq("base64")
    end

    it "can set if value" do
      user.define_schema { schema_if type: "string" }
      expect(user.schema_definition[:if]).to eq(type: "string")
    end

    it "can set then value" do
      user.define_schema { schema_then type: "string" }
      expect(user.schema_definition[:then]).to eq(type: "string")
    end

    it "can set else value" do
      user.define_schema { schema_else type: "string" }
      expect(user.schema_definition[:else]).to eq(type: "string")
    end

    it "can set not value" do
      user.define_schema { schema_not type: "string" }
      expect(user.schema_definition[:not]).to eq(type: "string")
    end

    it "can set enum value" do
      user.define_schema { enum %w[red green blue] }
      expect(user.schema_definition[:enum]).to eq(%w[red green blue])
    end

    it "can set const value" do
      user.define_schema { const "red" }
      expect(user.schema_definition[:const]).to eq("red")
    end

    it "can set default value" do
      user.define_schema { default "red" }
      expect(user.schema_definition[:default]).to eq("red")
    end

    it "can set examples value" do
      user.define_schema { examples %w[red green blue] }
      expect(user.schema_definition[:examples]).to eq(%w[red green blue])
    end

    it "can set max_length value" do
      user.define_schema { max_length 10 }
      expect(user.schema_definition[:maxLength]).to eq(10)
    end

    it "can set min_length value" do
      user.define_schema { min_length 5 }
      expect(user.schema_definition[:minLength]).to eq(5)
    end

    it "can set pattern value" do
      user.define_schema { pattern "^S_" }
      expect(user.schema_definition[:pattern]).to eq("^S_")
    end

    it "can set maximum value" do
      user.define_schema { maximum 10 }
      expect(user.schema_definition[:maximum]).to eq(10)
    end

    it "can set exclusive_maximum value" do
      user.define_schema { exclusive_maximum 10 }
      expect(user.schema_definition[:exclusiveMaximum]).to eq(10)
    end

    it "can set minimum value" do
      user.define_schema { minimum 5 }
      expect(user.schema_definition[:minimum]).to eq(5)
    end

    it "can set exclusive_minimum value" do
      user.define_schema { exclusive_minimum 5 }
      expect(user.schema_definition[:exclusiveMinimum]).to eq(5)
    end

    it "can set multiple_of value" do
      user.define_schema { multiple_of 5 }
      expect(user.schema_definition[:multipleOf]).to eq(5)
    end

    it "can set max_items value" do
      user.define_schema { max_items 5 }
      expect(user.schema_definition[:maxItems]).to eq(5)
    end

    it "can set min_items value" do
      user.define_schema { min_items 2 }
      expect(user.schema_definition[:minItems]).to eq(2)
    end

    it "can set unique_items value" do
      user.define_schema { unique_items true }
      expect(user.schema_definition[:uniqueItems]).to eq(true)
    end

    it "can set max_properties value" do
      user.define_schema { max_properties 5 }
      expect(user.schema_definition[:maxProperties]).to eq(5)
    end

    it "can set min_properties value" do
      user.define_schema { min_properties 2 }
      expect(user.schema_definition[:minProperties]).to eq(2)
    end

    it "can set a combination of schema keywords and properties" do
      user.define_schema do
        _schema "https://json-schema.org/draft/2020-12/schema"
        _id "https://example.com/schemas/user"
        description "Some description"
        type "object"
        title "User"
        property "name", type: "string"
        required ["name"]
      end

      expect(user.schema_definition[:_schema]).to eq("https://json-schema.org/draft/2020-12/schema")
      expect(user.schema_definition[:_id]).to eq("https://example.com/schemas/user")
      expect(user.schema_definition[:description]).to eq("Some description")
      expect(user.schema_definition[:type]).to eq("object")
      expect(user.schema_definition[:title]).to eq("User")
      expect(user.schema_definition[:properties]["name"]).to eq(type: "string")
      expect(user.schema_definition[:required]).to eq(["name"])
    end
  end
end
