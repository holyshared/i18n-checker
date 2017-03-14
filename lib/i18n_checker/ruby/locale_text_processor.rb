require 'parser'
require 'parser/current'

module I18nChecker
  module Ruby
    class LocaleTextProcessor < Parser::AST::Processor
      attr_reader :file, :locale_texts

      def initialize(file:, locale_texts: [])
        @file = file
        @locale_texts = locale_texts
      end

      def on_send(node)
        receiver_node, method_name, *arg_nodes = *node
        return super(node) unless method_name == :t
        arg_node = arg_nodes.first
        locale_texts << I18nChecker::Locale::LocaleText.new(
          file: file,
          line: arg_node.loc.line,
          column: arg_node.loc.column + 1,
          text: arg_node.children.first
        )
        super(node)
      end
    end
  end
end
