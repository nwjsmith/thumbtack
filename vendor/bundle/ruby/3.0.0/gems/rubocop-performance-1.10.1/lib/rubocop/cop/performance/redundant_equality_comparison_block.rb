# frozen_string_literal: true

module RuboCop
  module Cop
    module Performance
      # This cop checks for uses `Enumerable#all?`, `Enumerable#any?`, `Enumerable#one?`,
      # and `Enumerable#none?` are compared with `===` or similar methods in block.
      #
      # By default, `Object#===` behaves the same as `Object#==`, but this
      # behavior is appropriately overridden in subclass. For example,
      # `Range#===` returns `true` when argument is within the range.
      # Therefore, It is marked as unsafe by default because `===` and `==`
      # do not always behave the same.
      #
      # @example
      #   # bad
      #   items.all? { |item| pattern === item }
      #   items.all? { |item| item == other }
      #   items.all? { |item| item.is_a?(Klass) }
      #   items.all? { |item| item.kind_of?(Klass) }
      #
      #   # good
      #   items.all?(pattern)
      #
      class RedundantEqualityComparisonBlock < Base
        extend AutoCorrector
        extend TargetRubyVersion

        minimum_target_ruby_version 2.5

        MSG = 'Use `%<prefer>s` instead of block.'

        TARGET_METHODS = %i[all? any? one? none?].freeze
        COMPARISON_METHODS = %i[== === is_a? kind_of?].freeze
        IS_A_METHODS = %i[is_a? kind_of?].freeze

        def on_block(node)
          return unless TARGET_METHODS.include?(node.method_name) && node.arguments.one?

          block_argument = node.arguments.first
          block_body = node.body
          return unless use_equality_comparison_block?(block_body)
          return if same_block_argument_and_is_a_argument?(block_body, block_argument)
          return unless (new_argument = new_argument(block_argument, block_body))

          range = offense_range(node)
          prefer = "#{node.method_name}(#{new_argument})"

          add_offense(range, message: format(MSG, prefer: prefer)) do |corrector|
            corrector.replace(range, prefer)
          end
        end

        private

        def use_equality_comparison_block?(block_body)
          block_body.send_type? && COMPARISON_METHODS.include?(block_body.method_name)
        end

        def same_block_argument_and_is_a_argument?(block_body, block_argument)
          return false unless IS_A_METHODS.include?(block_body.method_name)

          block_argument.source == block_body.first_argument.source
        end

        def new_argument(block_argument, block_body)
          if block_argument.source == block_body.receiver.source
            block_body.first_argument.source
          elsif block_argument.source == block_body.first_argument.source
            block_body.receiver.source
          end
        end

        def offense_range(node)
          node.send_node.loc.selector.join(node.source_range.end)
        end
      end
    end
  end
end
