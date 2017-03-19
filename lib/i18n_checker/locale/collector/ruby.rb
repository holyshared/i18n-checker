require 'parser'
require 'parser/current'
require 'i18n_checker/collectible'
require 'i18n_checker/locale/texts'
require 'i18n_checker/locale/text_processor'

module I18nChecker
  module Locale
    module Collector
      class Ruby
        include I18nChecker::Collectible

        attr_reader :file_caches

        def initialize(file_caches = I18nChecker::Cache::Files.new)
          @file_caches = file_caches
        end

        def collect(source_file)
          I18nChecker::Locale::Texts.new(process(source_file))
        end

        private

          def buffer_of(source_file)
            source = file_caches.read(source_file).to_s
            source_buffer = Parser::Source::Buffer.new('(string)')
            source_buffer.source = source
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
