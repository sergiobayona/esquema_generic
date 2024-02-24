module EsquemaGeneric
  class BaseValidator
    def initialize(property_name, value)
      @property_name = property_name
      @value = value
    end

    def validate
      raise NotImplementedError, "#{self.class.name}#validate must be implemented"
    end
  end
end
