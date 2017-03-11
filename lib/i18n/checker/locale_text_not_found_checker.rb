require "i18n/checker/detector/locale_text_not_found"
require "i18n/checker/detector/locale_text_result"
require "i18n/checker/detector/detected_result"

module I18n
  module Checker
    class LocaleTextNotFoundChecker
      def initialize(locale_texts: [], reporter:)
        @reporter = reporter
        @locale_texts = locale_texts
      end

      def check(locale_files = [])
        not_found_detector = I18n::Checker::Detector::LocaleTextNotFound.new(locale_files)
        not_found_result = @locale_texts.detect(not_found_detector) 
        @reporter.report not_found_result
      end
    end
  end
end
