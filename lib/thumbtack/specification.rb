# encoding: utf-8

module Thumbtack
  # Internal: Validates and translates user-provided parameters to their
  # Pinboard-supported equivalents
  class Specification

    # Create a new Specification.
    #
    # type_handlers - A Hash mapping parameter names to their type handlers.
    def initialize(type_handlers)
      @type_handlers = type_handlers
    end

    # Validate and translate user-provided parameters to their
    # Pinboard-supported equivalents.
    #
    # arguments - A Hash mapping parameter names to their user-provided values.
    #
    # Returns the parameters translated to their Pinboard equivalents.
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
end
