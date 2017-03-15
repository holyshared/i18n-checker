require 'parser'
require 'parser/current'

module I18nChecker
  module Locale
    module Collector
      class RubyCollector
        def collect(source_file)
          I18nChecker::Locale::LocaleTexts.new(process(source_file))
        end

        private

        def buffer_of(source_file)
          source_buffer = Parser::Source::Buffer.new('(string)')
          source_buffer.source = File.read(source_file)
          source_buffer
        end

        def parse_source(source_file)
          parser = Parser::CurrentRuby.new
          parser.parse(buffer_of(source_file))
        end

        def process(source_file)
          processor = I18nChecker::Locale::TextProcessor.new(file: source_file)
          processor.process(parse_source(source_file))
          processor.locale_texts
        end
      end
    end
  end
end
