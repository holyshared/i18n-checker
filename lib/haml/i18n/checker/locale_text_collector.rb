require 'haml_parser'
require 'haml_parser/parser'

module Haml
  module I18n
    module Checker
      class LocaleTextCollector
        def initialize()
          @texts = []
        end

        def collect(template)
          parser = HamlParser::Parser.new
          ast = parser.call(template)
          collect_locale_texts(parser.call(template))
          @texts
        end

        private

        def collect_locale_texts(ast)
          oneline_script(ast)
          return unless ast.respond_to?(:children)
          ast.children.each { |child| collect_locale_texts(child) }
        end

        def oneline_script(ast)
          return unless ast.respond_to?(:oneline_child)
          return unless ast.oneline_child.kind_of?(HamlParser::Ast::Script)
          script_node = ast.oneline_child
          return unless translate_script = script_node.script.match(/^t\(\'+(.+)\'+\)$/)
          @texts << translate_script[1]
        end
      end
    end
  end
end
