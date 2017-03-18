require "i18n_checker/detector/locale_text_not_found"
require "i18n_checker/detector/locale_text_result"
require "i18n_checker/detector/detected_result"

module I18nChecker
  class LocaleTextNotFoundChecker
    def initialize(locale_texts: [], locale_files: [], reporter:)
      @reporter = reporter
      @locale_texts = locale_texts
      @locale_files = locale_files
    end

    def check
      not_found_detector = I18nChecker::Detector::LocaleTextNotFound.new(@locale_files)
      not_found_result = @locale_texts.detect(not_found_detector) 
      @reporter.report not_found_result
    end
  end
end
