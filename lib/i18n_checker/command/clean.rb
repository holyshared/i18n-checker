require 'i18n_checker/unused/detector'

module I18nChecker
  module Command
    class Clean
      def initialize(locale_files: [], source_files: [], reporter:)
        @reporter = reporter
        @locale_texts = I18nChecker::Locale.texts_of(source_files)
        @locale_files = I18nChecker::Locale.load_of(locale_files)
        @unused_detector = I18nChecker::Unused::Detector.new(@locale_files)
      end

      def run
        unused_result = @locale_texts.detect(@unused_detector)
        @reporter.report unused_result
        unused_result.apply(@locale_files)
        yield unused_result if block_given?
      end
    end
  end
end
