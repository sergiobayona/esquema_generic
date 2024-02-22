# Esquema Generic

Esquema is a Ruby library for JSON Schema generation.

Example Use:

```ruby
class User
  include EsquemaGeneric::Model

  define_schema do
    model_description "A user of the system"
    property :name, type: "string", description: "The user's name", title: "Full Name"
    property :email, type: "string", description: "The user's email", format: "email", title: "Email Address"
    property :group, type: "number", enum: [1, 2, 3], default: 1, description: "The user's group"
    property :age, type: "integer", minimum: 18, maximum: 100, description: "The user's age"
    property :tags, type: "array", items: { type: "string" }, minItems: 1, uniqueItems: true, description: "The user's tags"
  end
end
```

Calling `User.json_schema` will return the JSON Schema for the User model:

```json
{
    "title": "User model",
    "type": "object",
    "properties": {
        "name": {
            "title": "Full Name",
            "description": "The user's name",
            "type": "string"
        },
        "email": {
            "title": "Email Address",
            "description": "The user's email",
            "type": "string",
            "format": "email"
        },
        "group": {
            "type": "number",
            "enum": [1, 2, 3],
            "default": 1,
            "description": "The user's group"
        },
        "age": {
            "type": "integer",
            "minimum": 18,
            "maximum": 100,
            "description": "The user's age"
        },
        "tags": {
            "type": "array",
            "items": {
                "type": "string"
            },
            "minItems": 1,
            "uniqueItems": true,
            "description": "The user's tags"
        }
    },
    "required:": [
        "name",
        "email",
        "group",
        "age",
        "tags"
    ]
}
```

## Installation

 install the gem by running the following command in your terminal:

    $ gem install esquema_generic

## Usage

Simply include the `EsquemaGeneric::Model` module in your Ruby class and call the `json_schema` method to generate the JSON Schema for the model.


## Schema Definition

In the example above, the `define_schema` method is used to add a description to the schema document. The `property` method is used to define the properties of the schema document. The `property` method accepts the name of the property and a hash of options. The options are used specify the type and keywords for validation.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sergiobayona/esquema_generic. 

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

