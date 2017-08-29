require 'i18n_checker/unused/detector'

module I18nChecker
  module Command
    class UnusedCheck
      def initialize(locale_file_paths: [], source_paths: [], reporter:)
        @reporter = reporter
        @locale_texts = I18nChecker::Locale.texts_of(source_paths)
        @locale_files = I18nChecker::Locale.load_of(locale_file_paths)
        @unused_detector = I18nChecker::Unused::Detector.new(@locale_files)
      end

      def run
        unused_result = @locale_texts.detect(@unused_detector)
        @reporter.report unused_result
        yield unused_result if block_given?
      end
    end
  end
end
