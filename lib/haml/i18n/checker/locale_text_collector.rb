require 'haml_parser'
require 'haml_parser/parser'

module Haml
  module I18n
    module Checker
      class LocaleTextCollector
        def collect(template)
          parser = HamlParser::Parser.new
          ast = parser.call(template)
          LocaleTexts.new(collect_locale_texts(parser.call(template)))
        end

        private

        def collect_locale_texts(ast)
          locale_texts = []
          locale_texts << collect_locale_text(ast)
          return unless ast.respond_to?(:children)
          locale_texts << ast.children.map { |child| collect_locale_texts(child) }
          locale_texts.flatten.compact
        end

        def collect_locale_text(ast)
          return unless ast.respond_to?(:oneline_child)
          return unless ast.oneline_child.kind_of?(HamlParser::Ast::Script)
          script_node = ast.oneline_child
          return unless translate_script = script_node.script.match(/^t\(\'+(.+)\'+\)$/)
          translate_script[1]
        end
      end
    end
  end
end
