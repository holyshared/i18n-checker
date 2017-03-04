require 'haml_parser'
require 'haml_parser/parser'

module Haml
  module I18n
    module Checker
      class LocaleTextCollector
        def collect(template)
          parser = HamlParser::Parser.new
          ast = parser.call(template)
        end
      end
    end
  end
end
