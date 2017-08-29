require 'i18n_checker/not_found/detector'
require 'i18n_checker/not_found/text'
require 'i18n_checker/not_found/result'

module I18nChecker
  module Command
    class ReferenceCheck
      def initialize(locale_file_paths: [], source_paths: [], reporter:)
        @reporter = reporter
        @locale_texts = I18nChecker::Locale.texts_of(source_paths)
        @locale_files = I18nChecker::Locale.load_of(locale_file_paths)
      end

      def run
        not_found_detector = I18nChecker::NotFound::Detector.new(@locale_files)
        not_found_result = @locale_texts.detect(not_found_detector)
        @reporter.report not_found_result
        yield not_found_result if block_given?
      end
    end
  end
end
