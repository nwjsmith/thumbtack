# encoding: utf-8

class Specification
  def initialize(type_handlers)
    @type_handlers = type_handlers
  end

  def parameters(arguments)
    Hash[
      arguments.map do |name, value|
        type_handler = @type_handlers.fetch(name)
        type_handler.validate(value)
        [name, type_handler.to_parameter(value)]
      end
    ]
  end
end
