# encoding: utf-8

module Thumbtack
  # Validates and translates user-provided parameters to their Pinboard
  # supported equivalents
  #
  # @api private
  class Specification
    # Initialize a Specification
    #
    # @param [Hash<Symbol, Type>] type_handlers
    #   a map of parameter names to their type handlers
    def initialize(type_handlers)
      @type_handlers = type_handlers
    end

    # Validate and translate user-provided parameters to their
    # Pinboard-supported values
    #
    # @param [Hash<Symbol, Object>] arguments
    #   parameter names associated with their values
    #
    # @return [Hash<Symbol, Object>]
    #   parameter names associated with translations to their Pinboard values
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
